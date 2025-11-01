import 'package:digital_egypt_pioneers/bloc/cart/cart_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart_detail/cart_detail_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart_detail/cart_detail_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart_detail/cart_detail_state.dart';
import 'package:digital_egypt_pioneers/models/shoe_model.dart';
import 'package:digital_egypt_pioneers/screens/product_detail_screen.dart';
import 'package:digital_egypt_pioneers/widgets/ItemCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';

class CartScreen extends StatefulWidget {
  final String cartId;

  const CartScreen({super.key, required this.cartId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, int> _localItemAmounts = {};
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    context.read<CartDetailBloc>().add(LoadCartDetails(widget.cartId));
  }

  // --- (Other dialogs: _showAddItemDialog, _showShareDialog, _showCollaboratorsDialog remain unchanged) ---

  void _showShareDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Share List'),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Enter user's email"),
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Share'),
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  context.read<CartDetailBloc>().add(
                    ShareCart(widget.cartId, email),
                  );
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showCollaboratorsDialog(
      BuildContext context,
      List<Map<String, dynamic>> collaborators,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Collaborators'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: collaborators.length,
              itemBuilder: (context, index) {
                final email = collaborators[index]['email'] ?? 'Unknown user';
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(email),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // --- NEW: Confirmation dialog for removing an item ---
  void _showRemoveConfirmationDialog(BuildContext context, Shoe shoe) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove Item?'),
        content: Text('Are you sure you want to remove ${shoe.name} from this list?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          TextButton(
            child: const Text('Remove', style: TextStyle(color: Colors.redAccent)),
            onPressed: () {
              setState(() {
                // Remove the item from the local map
                _localItemAmounts.remove(shoe.id);
                // Mark that we have changes to save
                _hasChanges = true;
              });
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${shoe.name} removed. Press save to confirm.'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        (context.watch<AuthBloc>().state as Authenticated).user.uid;

    return BlocListener<CartDetailBloc, CartDetailState>(
      listener: (context, state) {
        if (state is CartDetailLoaded) {
          if (!_hasChanges) {
            setState(() {
              _localItemAmounts = Map<String, int>.from(state.itemsMap);
            });
          }

          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.actionError!),
                backgroundColor: Colors.redAccent,
              ),
            );
            context.read<CartDetailBloc>().add(ClearActionError());
          }
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.actionSuccess!),
                backgroundColor: Colors.green,
              ),
            );
            if (state.actionSuccess == "Cart saved successfully!") {
              setState(() {
                _hasChanges = false;
              });
            }
            context.read<CartDetailBloc>().add(ClearActionSuccess());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.save,
                color: _hasChanges ? Colors.amber : Colors.grey,
              ),
              onPressed: _hasChanges
                  ? () {
                context.read<CartDetailBloc>().add(
                  UpdateCartItems(widget.cartId, _localItemAmounts),
                );
              }
                  : null,
            ),
            BlocBuilder<CartDetailBloc, CartDetailState>(
              builder: (context, state) {
                if (state is CartDetailLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.group),
                    onPressed: () =>
                        _showCollaboratorsDialog(context, state.collaborators),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BlocBuilder<CartDetailBloc, CartDetailState>(
              builder: (context, state) {
                if (state is CartDetailLoaded) {
                  final cartData = state.cart.data() as Map<String, dynamic>;
                  if (currentUserId == cartData['ownerId']) {
                    return IconButton(
                      icon: const Icon(Icons.person_add_alt_1),
                      onPressed: () => _showShareDialog(context),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<CartDetailBloc, CartDetailState>(
          builder: (context, state) {
            if (state is CartDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartDetailLoaded) {
              final List<Shoe> items = state.items;

              // NEW: Filter items based on our local map
              final List<Shoe> itemsToShow = items.where((shoe) {
                return _localItemAmounts.containsKey(shoe.id);
              }).toList();

              if (itemsToShow.isEmpty) {
                // Check if the original list was empty or if local changes emptied it
                if (state.itemsMap.isEmpty) {
                  return const Center(child: Text('This list has no items yet.'));
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info_outline, size: 60, color: Colors.amber),
                        const SizedBox(height: 16),
                        const Text(
                          'All items have been removed.',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Press the Save button to confirm your changes.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: itemsToShow.length, // Use the filtered list
                itemBuilder: (context, index) {
                  final shoe = itemsToShow[index]; // Use the filtered list
                  final amount = _localItemAmounts[shoe.id] ?? 0;

                  return GestureDetector(
                    child: ItemCard(
                      imagePath: shoe.imageUrl,
                      itemName: shoe.name,
                      counterValue: amount,
                      price: shoe.price,
                      onIncrement: () {
                        setState(() {
                          _localItemAmounts[shoe.id] = amount + 1;
                          _hasChanges = true;
                        });
                      },
                      onDecrement: () {
                        // UPDATED: Allow decrementing to 0, but show confirmation
                        if (amount > 1) {
                          setState(() {
                            _localItemAmounts[shoe.id] = amount - 1;
                            _hasChanges = true;
                          });
                        } else if (amount == 1) {
                          // If at 1, trigger the remove confirmation
                          _showRemoveConfirmationDialog(context, shoe);
                        }
                      },
                      // UPDATED: Pass the new remove callback
                      onRemove: () {
                        _showRemoveConfirmationDialog(context, shoe);
                      },
                    ),
                    onTap: () {
                      final cartBloc = BlocProvider.of<CartBloc>(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: cartBloc,
                            child: ProductDetailScreen(shoe: shoe),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
            if (state is CartDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Loading cart...'));
          },
        ),
      ),
    );
  }
}