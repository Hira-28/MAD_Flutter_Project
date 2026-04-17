import 'package:flutter/material.dart';

class DishDetailPage extends StatelessWidget {
  final Map dish;

  const DishDetailPage({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dish["name"]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
           dish["image"],
            width: 60,
            errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.broken_image);
            },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Rating: ${dish["rating"]} ⭐",
                style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}