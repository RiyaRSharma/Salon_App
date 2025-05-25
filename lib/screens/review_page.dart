import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'home_page.dart';

class ReviewPage extends StatefulWidget {
  final Map<String, String> bookingDetails;

  const ReviewPage({super.key, required this.bookingDetails});

  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> {
  double rating = 0;
  final TextEditingController _commentController = TextEditingController();

  final Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000/api')); // 🔁 Replace with actual IP if testing on device

  final List<Map<String, dynamic>> reviews = [
    {"name": "Riya", "rating": 5, "comment": "Amazing service!"},
    {"name": "John", "rating": 4, "comment": "Good experience."},
  ];

  void submitReview() async {
    if (rating == 0 || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a rating and comment!')),
      );
      return;
    }

    try {
      final response = await dio.post('/reviews', data: {
        "userId": int.parse(widget.bookingDetails["userId"]!),
        "salonId": int.parse(widget.bookingDetails["salonId"]!),
        "rating": rating,
        "comment": _commentController.text,
      });

      if (response.statusCode == 201) {
        setState(() {
          reviews.add({
            "name": "You",
            "rating": rating,
            "comment": _commentController.text,
          });
        });

        _commentController.clear();
        rating = 0;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review submitted successfully!')),
        );

        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit review')),
        );
      }
    } catch (e) {
      print('❌ Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error submitting review')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews & Ratings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review for ${widget.bookingDetails["service"]} with ${widget.bookingDetails["staff"]} at ${widget.bookingDetails["slot"]}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Customer Reviews',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: reviews.isEmpty
                  ? const Text('No reviews yet.')
                  : ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ListTile(
                    leading: const Icon(Icons.star, color: Colors.orange),
                    title: Text(review['name']),
                    subtitle: Text('${review['rating']} stars\n${review['comment']}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Add Your Review',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Write your feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: submitReview,
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
