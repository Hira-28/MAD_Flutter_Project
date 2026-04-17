import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'data.dart';
import 'add_review_page.dart';
import 'top_rated_page.dart';
import 'view_reviews_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Sort by rating
    hotels.sort((a, b) => b.averageRating.compareTo(a.averageRating));

    return Scaffold(
      appBar: AppBar(title: Text("Dish Score Dashboard")),

      // ✅ Drawer Added
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.restaurant, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Dish Score",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text("Add Review"),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddReviewPage()),
                );
                refresh();
              },
            ),

            ListTile(
              leading: Icon(Icons.star),
              title: Text("Top Rated"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TopRatedPage()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {},
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddReviewPage()),
          );
          refresh();
        },
        child: Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: hotels.map((hotel) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(hotel.image, fit: BoxFit.cover),

                      Container(color: Colors.black.withOpacity(0.4)),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          hotel.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 15),

            // 🔥 Section Title
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Top Hotels",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // 🔥 Hotel Cards
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: hotels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final hotel = hotels[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.network(
                          hotel.image,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              hotel.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 5),

                            // Rating
                            Text(
                              "Avg Rating: ${hotel.averageRating.toStringAsFixed(2)} (${hotel.reviews.length} reviews)",
                            ),

                            SizedBox(height: 10),

                            // Buttons
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ViewReviewsPage(hotel: hotel),
                                      ),
                                    );
                                  },
                                  child: Text("View"),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddReviewPage(),
                                      ),
                                    );
                                    refresh();
                                  },
                                  child: Text("Add Review"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            // 🔥 Stats Section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Overall Stats",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statCard("Reviews", totalReviews().toString()),
                statCard("Hotels", hotels.length.toString()),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔥 Stats Helper
  int totalReviews() {
    int total = 0;
    for (var h in hotels) {
      total += h.reviews.length;
    }
    return total;
  }

  Widget statCard(String title, String value) {
    return Card(
      elevation: 3,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
}
