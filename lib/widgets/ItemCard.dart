import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final int counterValue;
  final double price;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? onRemove; // NEW: Optional remove callback

  const ItemCard({
    required this.imagePath,
    required this.itemName,
    required this.counterValue,
    required this.price,
    required this.onIncrement,
    required this.onDecrement,
    this.onRemove, // NEW: Add to constructor
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
      // UPDATED: Wrap content in a Column to add the button below
      child: Column(
        children: [
          // This Row is the original content
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  // UPDATED: Only round top-left if the remove button is absent
                  bottomLeft: Radius.circular(onRemove == null ? 12.0 : 0),
                ),
                child: Image.asset(
                  imagePath,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$price EGP",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_up_sharp,
                        color: Colors.white),
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
                    icon: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: Colors.white),
                    onPressed: onDecrement,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),

          // --- NEW: Conditionally add the remove button ---
          if (onRemove != null)
            Column(
              children: [
                Divider(height: 1, color: Colors.grey[700]),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: onRemove,
                    icon:
                    const Icon(Icons.delete_outline, color: Colors.redAccent),
                    label:
                    const Text('Remove', style: TextStyle(color: Colors.redAccent)),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}