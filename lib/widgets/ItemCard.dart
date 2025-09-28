import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final int counterValue;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ItemCard({
    required this.imagePath,
    required this.itemName,
    required this.counterValue,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
            ),
            child: Image.asset(
              imagePath,
              width: 200,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Text(
              itemName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_up_sharp, color: Colors.white),
                onPressed: onIncrement,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                counterValue.toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),
                onPressed: onDecrement,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}