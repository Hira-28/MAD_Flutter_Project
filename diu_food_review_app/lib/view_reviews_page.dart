import 'package:flutter/material.dart';
import 'hotel_model.dart';

class ViewReviewsPage extends StatelessWidget {
  final Hotel hotel;

  ViewReviewsPage({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: hotel.reviews.isEmpty
          ? Center(child: Text("No reviews yet"))
          : ListView.builder(
              itemCount: hotel.reviews.length,
              itemBuilder: (context, index) {
                final review = hotel.reviews[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    subtitle: Text(review.comment),
                  ),
                );
              },
            ),
    );
  }
}