// lib/screens/CartListScreen.dart

import 'package:digital_egypt_pioneers/bloc/auth/auth_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_egypt_pioneers/bloc/cart_detail/cart_detail_bloc.dart';
import 'package:digital_egypt_pioneers/screens/CartScreen.dart';
import 'package:digital_egypt_pioneers/services/firestore_service.dart';
import 'package:digital_egypt_pioneers/services/product_repository.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      _userId = authState.user.uid;
      // Load carts immediately
      context.read<CartBloc>().add(LoadCarts(_userId));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- NEW: Confirmation Dialog ---
  void _showDeleteConfirmationDialog(
      BuildContext context, {
        required String cartId,
        required String cartName,
        required bool isOwner,
      }) {
    final title = isOwner ? 'Delete List?' : 'Leave List?';
    final content = isOwner
        ? 'Are you sure you want to permanently delete "$cartName"?'
        : 'Are you sure you want to leave "$cartName"? You will lose access unless you are invited again.';
    final actionText = isOwner ? 'Delete' : 'Leave';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(actionText, style: const TextStyle(color: Colors.redAccent)),
              onPressed: () {
                if (isOwner) {
                  context.read<CartBloc>().add(DeleteCart(cartId));
                } else {
                  context.read<CartBloc>().add(LeaveCart(cartId, _userId));
                }
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping Lists'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Lists'),
            Tab(text: 'Shared With Me'),
          ],
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        // NEW: Listen for action errors
        listener: (context, state) {
          if (state is CartsLoaded) {
            if (state.actionError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.actionError!),
                  backgroundColor: Colors.redAccent,
                ),
              );
              context.read<CartBloc>().add(ClearCartActionError());
            }
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartsLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  // "My Lists" Tab
                  _buildCartListView(context, state.ownedCarts, isOwner: true),
                  // "Shared With Me" Tab
                  _buildCartListView(context, state.sharedCarts, isOwner: false),
                ],
              );
            }
            if (state is CartsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Welcome to your carts!'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCartDialog(context, _userId),
        child: const Icon(Icons.add),
      ),
    );
  }

  // UPDATED: Added isOwner parameter
  Widget _buildCartListView(
      BuildContext context,
      List<QueryDocumentSnapshot> carts, {
        required bool isOwner,
      }) {
    if (carts.isEmpty) {
      return const Center(
        child: Text('No lists in this category.'),
      );
    }
    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index].data() as Map<String, dynamic>;
        final cartId = carts[index].id;
        final cartName = cart['name'] ?? 'Unnamed List';

        return ListTile(
          title: Text(cartName),
          // UPDATED: Trailing icon
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: isOwner ? Colors.redAccent : Colors.grey[400],
            ),
            onPressed: () {
              // Call the new confirmation dialog
              _showDeleteConfirmationDialog(
                context,
                cartId: cartId,
                cartName: cartName,
                isOwner: isOwner,
              );
            },
          ),
          onTap: () {
            final cartBloc = BlocProvider.of<CartBloc>(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: cartBloc,
                      ),
                      BlocProvider(
                        create: (context) => CartDetailBloc(
                          firestoreService: FirestoreService(),
                          productRepository: FakeProductRepository(),
                        ),
                      ),
                    ],
                    child: CartScreen(cartId: cartId),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showAddCartDialog(BuildContext screenContext, String userId) {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: screenContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Shopping List'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter list name"),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final listName = nameController.text.trim();
                if (listName.isNotEmpty) {
                  screenContext.read<CartBloc>().add(AddCart(listName, userId));
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}