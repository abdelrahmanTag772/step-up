import 'package:flutter/material.dart';
import 'package:digital_egypt_pioneers/widgets/ItemCard.dart';

class Item {
  String title;
  int counter;

  Item({required this.title, required this.counter});
}

class CartScreen extends StatefulWidget {
  final int index;

  CartScreen({required this.index, super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Item> items = List<Item>.generate(
    20,
    (i) => Item(title: "Item ${i + 1}", counter: 1),
  );
  final List<String> users = List<String>.generate(5, (i) => "User ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart ${widget.index}')),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cart's Users",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,),
                    onPressed: () {},
                    child: Text(
                      "Add User",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.grey[850],
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        title: Text(
                          users[index],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.person, size: 16.0),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Items',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCard(
                      imagePath: 'assets/images/shoe_image.jpg',
                      itemName: items[index].title,
                      counterValue: items[index].counter,
                      onIncrement: () {
                        setState(() {
                          items[index].counter++;
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          if (items[index].counter > 1) {
                            setState(() {
                              items[index].counter--;
                            });
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 32.0, right: 0.0),
        // Adjusted padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: Colors.grey,
              label: const Text('Buy', style: TextStyle(fontSize: 16)),
              icon: const Icon(Icons.shopping_cart, size: 20),
              heroTag: null,
              elevation: 4.0,
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: Colors.grey,
              label: const Text('Save', style: TextStyle(fontSize: 16)),
              icon: const Icon(Icons.save, size: 20),
              heroTag: null,
              elevation: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
