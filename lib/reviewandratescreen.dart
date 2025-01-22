import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:predictivehealthcare/doctordetailscreen.dart';

class ReviewAndRatingScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const ReviewAndRatingScreen({super.key, required this.doctor});

  @override
  _ReviewAndRatingScreenState createState() => _ReviewAndRatingScreenState();
}

class _ReviewAndRatingScreenState extends State<ReviewAndRatingScreen> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a rating.'),
        ),
      );
      return;
    }

    if (_reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a review.'),
        ),
      );
      return;
    }

    // Handle review submission logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you for reviewing ${widget.doctor['name']}!'),
      ),
    );

    // Clear the inputs
    setState(() {
      _rating = 0.0;
      _reviewController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review ${widget.doctor['name']}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate ${widget.doctor['name']}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Center(
              child: RatingBar.builder(
                initialRating: 0.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Write a Review',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _submitReview;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorDetailsScreen(
                                doctor: {},
                              )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: const Text(
                  'Submit Review',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
