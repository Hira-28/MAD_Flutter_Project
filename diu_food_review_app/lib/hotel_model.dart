class Review {
  final String comment;
  final double rating;

  Review({required this.comment, required this.rating});
}

class Hotel {
  final String name;
  final String image;
  List<Review> reviews;

  Hotel({
    required this.name,
    required this.image,
    required this.reviews,
  });

  double get averageRating {
    if (reviews.isEmpty) return 0;
    double total = reviews.fold(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }
}