import 'package:digital_egypt_pioneers/bloc/auth/auth_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_state.dart';
import 'package:digital_egypt_pioneers/models/shoe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_egypt_pioneers/generated/l10n.dart'; // Flutter Intl

class ProductDetailScreen extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailScreen({super.key, required this.shoe});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void _showAddToCartDialog(BuildContext screenContext, Shoe shoe) {
    final loc = S.of(screenContext); // <<– استدعاء localization
    final newCartNameController = TextEditingController();
    final amountController = TextEditingController(text: "1");

    final authState = screenContext.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      ScaffoldMessenger.of(screenContext).showSnackBar(
        SnackBar(content: Text(loc.loginRequiredMessage)),
      );
      return;
    }
    final userId = authState.user.uid;

    showDialog(
      context: screenContext,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<CartBloc>(screenContext),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartsLoaded) {
                return AlertDialog(
                  title: Text(loc.addToListTitle(shoe.name)),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: amountController,
                          decoration: InputDecoration(
                            labelText: loc.amountLabel,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                final cartData = cart.data() as Map<String, dynamic>;
                                final cartName = cartData['name'] ?? loc.unnamedList;

                                return ListTile(
                                  title: Text(cartName),
                                  onTap: () {
                                    final amount = int.tryParse(amountController.text.trim()) ?? 1;
                                    screenContext.read<CartBloc>().add(
                                          AddItemToSpecificCart(
                                            cartId: cart.id,
                                            productId: shoe.id,
                                            amount: amount,
                                          ),
                                        );

                                    ScaffoldMessenger.of(screenContext).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.addedToList(amount.toString(), cartName)),
                                      ),
                                    );
                                    Navigator.of(dialogContext).pop();
                                  },
                                );
                              },
                            ),
                          ),
                        const Divider(),
                        TextField(
                          controller: newCartNameController,
                          decoration: InputDecoration(hintText: loc.orCreateNewList),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text(loc.cancel),
                      onPressed: () {
                        amountController.dispose();
                        newCartNameController.dispose();
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: Text(loc.createAndAdd),
                      onPressed: () {
                        final listName = newCartNameController.text.trim();
                        final amount = int.tryParse(amountController.text.trim()) ?? 1;
                        if (listName.isNotEmpty) {
                          screenContext.read<CartBloc>().add(
                                CreateCartAndAddItem(
                                  listName: listName,
                                  userId: userId,
                                  productId: shoe.id,
                                  amount: amount,
                                ),
                              );

                          ScaffoldMessenger.of(screenContext).showSnackBar(
                            SnackBar(
                              content: Text(loc.addedToNewList(amount.toString(), listName)),
                            ),
                          );

                          Navigator.of(dialogContext).pop();
                        }
                      },
                    ),
                  ],
                );
              }
              return AlertDialog(content: Center(child: Text(loc.loading)));
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context); // <<– localization

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
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${loc.brandLabel}: ${widget.shoe.brand}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${widget.shoe.price.toStringAsFixed(2)} ${loc.currency}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.amber[700], fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showAddToCartDialog(context, widget.shoe),
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text(loc.addToCart),
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
