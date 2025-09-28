import 'package:digital_egypt_pioneers/screens/CartScreen.dart';
import 'package:flutter/material.dart';

class CartListScreen extends StatelessWidget {
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carts'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text('Cart ${index + 1}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen(index: index)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
