import 'package:digital_egypt_pioneers/bloc/auth/auth_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_state.dart';
import 'package:digital_egypt_pioneers/models/shoe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailScreen({super.key, required this.shoe});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  void _showAddToCartDialog(BuildContext screenContext, Shoe shoe) {
    final newCartNameController = TextEditingController();
    final amountController = TextEditingController(text: "1");
    final userId =
        (screenContext.read<AuthBloc>().state as Authenticated).user.uid;

    showDialog(
      context: screenContext,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<CartBloc>(screenContext),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartsLoaded) {
                return AlertDialog(
                  title: Text('Add "${shoe.name}" to a list'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: amountController,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (state.ownedCarts.isNotEmpty)
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.ownedCarts.length,
                              itemBuilder: (context, index) {
                                final cart = state.ownedCarts[index];
                                return ListTile(
                                  title: Text(cart['name'] ?? 'Unnamed'),
                                  onTap: () {
                                    final amount = int.tryParse(
                                        amountController.text.trim()) ??
                                        1;
                                    // UPDATED: Use screenContext
                                    screenContext.read<CartBloc>().add(
                                      AddItemToSpecificCart(
                                        cartId: cart.id,
                                        productId: shoe.id,
                                        amount: amount,
                                      ),
                                    );
                                    Navigator.of(dialogContext).pop();
                                    ScaffoldMessenger.of(screenContext)
                                        .showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Added $amount to ${cart['name']}')),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        const Divider(),
                        TextField(
                          controller: newCartNameController,
                          decoration: const InputDecoration(
                              hintText: 'Or create a new list'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        amountController.dispose();
                        newCartNameController.dispose();
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Create & Add'),
                      onPressed: () {
                        final listName = newCartNameController.text.trim();
                        final amount =
                            int.tryParse(amountController.text.trim()) ?? 1;
                        if (listName.isNotEmpty) {
                          // UPDATED: Use screenContext
                          screenContext.read<CartBloc>().add(
                            CreateCartAndAddItem(
                              listName: listName,
                              userId: userId,
                              productId: shoe.id,
                              amount: amount,
                            ),
                          );
                          Navigator.of(dialogContext).pop();
                          ScaffoldMessenger.of(screenContext).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Added $amount to new list: $listName')),
                          );
                        }
                      },
                    ),
                  ],
                );
              }
              return const AlertDialog(
                  content: Center(child: CircularProgressIndicator()));
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoe.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.shoe.imageUrl,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.shoe.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Brand: ${widget.shoe.brand}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${widget.shoe.price.toStringAsFixed(2)} EGP',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.amber[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showAddToCartDialog(context, widget.shoe),
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}