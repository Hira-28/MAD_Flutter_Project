import 'package:flutter/material.dart';
import 'data.dart';

class TopRatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Sort highest rating first
    hotels.sort((a, b) => b.averageRating.compareTo(a.averageRating));

    return Scaffold(
      appBar: AppBar(title: Text("Top Rated Hotels")),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(hotel.image, width: 60),
              title: Text(hotel.name),
              subtitle: Text(
                  "Rating: ${hotel.averageRating.toStringAsFixed(2)} ⭐"),
              trailing: Text("#${index + 1}"),
            ),
          );
        },
      ),
    );
  }
}