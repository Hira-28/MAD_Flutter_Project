import 'package:flutter/material.dart';
import 'data.dart';
import 'hotel_model.dart';

class AddReviewPage extends StatefulWidget {
  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  Hotel? selectedHotel;
  double rating = 3;
  TextEditingController commentController = TextEditingController();

  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Colors.orange,
        size: 30,
      ),
      onPressed: () {
        setState(() {
          rating = index + 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Review")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Select Hotel",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  DropdownButtonFormField<Hotel>(
                    value: selectedHotel,
                    items: hotels.map((hotel) {
                      return DropdownMenuItem(
                        value: hotel,
                        child: Text(hotel.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHotel = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text("Rating",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  Row(
                    children: List.generate(5, (index) => buildStar(index)),
                  ),

                  SizedBox(height: 20),

                  Text("Your Experience",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write your experience...",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        if (selectedHotel != null &&
                            commentController.text.isNotEmpty) {
                          selectedHotel!.reviews.add(
                            Review(
                              comment: commentController.text,
                              rating: rating,
                            ),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text("Submit Review",
                          style: TextStyle(fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}