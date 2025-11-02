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
import 'package:digital_egypt_pioneers/generated/l10n.dart'; 

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
      context.read<CartBloc>().add(LoadCarts(_userId));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- Confirmation Dialog ---
  void _showDeleteConfirmationDialog(
    BuildContext context, {
    required String cartId,
    required String cartName,
    required bool isOwner,
  }) {
    final loc = S.of(context);
    final title = isOwner ? loc.deleteList : loc.leaveList;
    final content = isOwner
        ? loc.deleteConfirmation(cartName)
        : loc.leaveConfirmation(cartName);
    final actionText = isOwner ? loc.delete : loc.leave;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(loc.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(
                actionText,
                style: const TextStyle(color: Colors.redAccent),
              ),
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
    final loc = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.myShoppingLists),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: loc.myLists),
            Tab(text: loc.sharedWithMe),
          ],
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartsLoaded && state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.actionError!),
                backgroundColor: Colors.redAccent,
              ),
            );
            context.read<CartBloc>().add(ClearCartActionError());
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
                  _buildCartListView(context, state.ownedCarts, isOwner: true),
                  _buildCartListView(context, state.sharedCarts, isOwner: false),
                ],
              );
            }
            if (state is CartsError) {
              return Center(child: Text('${loc.error}: ${state.message}'));
            }
            return Center(child: Text(loc.welcomeToYourCarts));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCartDialog(context, _userId),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCartListView(
    BuildContext context,
    List<QueryDocumentSnapshot> carts, {
    required bool isOwner,
  }) {
    final loc = S.of(context);

    if (carts.isEmpty) {
      return Center(child: Text(loc.noLists));
    }

    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index].data() as Map<String, dynamic>;
        final cartId = carts[index].id;
        final cartName = cart['name'] ?? loc.unnamedList;

        return ListTile(
          title: Text(cartName),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: isOwner ? Colors.redAccent : Colors.grey[400],
            ),
            onPressed: () {
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
                      BlocProvider.value(value: cartBloc),
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
    final loc = S.of(screenContext);
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: screenContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(loc.newShoppingList),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: loc.enterListName),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: Text(loc.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(loc.add),
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
