import 'package:digital_egypt_pioneers/bloc/auth/auth_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_state.dart';
import 'package:digital_egypt_pioneers/bloc/product/product_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/product/product_state.dart';
import 'package:digital_egypt_pioneers/models/shoe_model.dart';
import 'package:digital_egypt_pioneers/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_egypt_pioneers/generated/l10n.dart'; 

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> banners = [
    "assets/images/shoe1.jpg",
    "assets/images/shoe6.jpg",
    "assets/images/shoe9.jpg",
  ];

  void _showAddToCartDialog(BuildContext screenContext, Shoe shoe) {
    final loc = S.of(screenContext);
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
                      onPressed: () => Navigator.of(dialogContext).pop(),
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
    final loc = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            tooltip: loc.notifications,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: loc.searchHint,
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        banners[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.amber : Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: Text(loc.loading));
                }
                if (state is ProductLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          loc.featuredShoes,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final shoe = state.products[index];
                          return GestureDetector(
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
                            child: Card(
                              color: Colors.grey[850],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                          const BorderRadius.vertical(top: Radius.circular(15)),
                                      child: Image.asset(
                                        shoe.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      shoe.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    "${shoe.price.toStringAsFixed(2)} ${loc.currency}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  ElevatedButton.icon(
                                    onPressed: () => _showAddToCartDialog(context, shoe),
                                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                                    label: Text(loc.add),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber[800],
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                if (state is ProductError) {
                  return Center(child: Text(loc.errorLoadingProducts));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
