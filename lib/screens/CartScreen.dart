import 'package:flutter/material.dart';
import 'package:digital_egypt_pioneers/widgets/ItemCard.dart';

class Item {
  String title;
  int counter;
  String imagePath;
  double price;

  Item({
    required this.title,
    required this.counter,
    required this.imagePath,
    required this.price,
  });
}

class CartScreen extends StatefulWidget {
  final int index;

  const CartScreen({required this.index, super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Item> items = List<Item>.generate(
    5,
    (i) => Item(
      title: "Shoe ${i + 1}",
      counter: 1,
      imagePath: "assets/images/shoe${i + 1}.jpg", // ✅ بدون "_"
      price: 500 + (i * 100),
    ),
  );

  final List<String> users = List<String>.generate(5, (i) => "User ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart ${widget.index + 1}')),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Users Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cart's Users",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Add User",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        title: Text(
                          users[index],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.person, size: 18.0),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Items Section
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
                      imagePath: items[index].imagePath,
                      itemName: items[index].title,
                      counterValue: items[index].counter,
                      price: items[index].price,
                      onIncrement: () {
                        setState(() {
                          items[index].counter++;
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          if (items[index].counter > 1) {
                            items[index].counter--;
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
