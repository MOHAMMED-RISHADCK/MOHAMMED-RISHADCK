import 'package:flutter/material.dart';
import 'package:predictivehealthcare/createappointment.dart';
import 'package:predictivehealthcare/reviewandratescreen.dart';
import 'package:predictivehealthcare/api/reviewapi.dart';


class DoctorDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  List<Map<String, dynamic>> _reviews = [];
  bool _isLoading = true;
  double _averageRating = 0.0;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    final reviews = await ReviewApi.fetchReviews(widget.doctor["id"]);
    
    if (mounted) {
      setState(() {
        _reviews = reviews;
        _isLoading = false;

        // Calculate average rating
        if (_reviews.isNotEmpty) {
          _averageRating = _reviews
              .map((review) => double.tryParse(review['rating'].toString()) ?? 0.0)
              .reduce((a, b) => a + b) /
              _reviews.length;
        }
      });
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAppointmentScreen(
            doctorid: widget.doctor,
            selectedDate: _selectedDate!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor['name'] ?? 'Doctor Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Details Section
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: widget.doctor['imageUrl'] != null &&
                          widget.doctor['imageUrl']!.isNotEmpty
                      ? Image.network(
                          widget.doctor['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/doc3.jpg',
                          width: 50,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor['Name'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.doctor['specialization'] ?? 'N/A',
                        style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                      Text(
                        widget.doctor['qualification'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      Row(
                        children: [
                          const Text('Rating: ', style: TextStyle(fontSize: 16.0)),
                          const Icon(Icons.star, color: Colors.amber, size: 20.0),
                          Text(
                            _averageRating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text("Select Appointment Date"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Doctor Reviews & Ratings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewAndRatingScreen(
                      doctor: widget.doctor,
                      doctorid: widget.doctor["id"],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.reviews),
              label: const Text('Add Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _reviews.isEmpty
                    ? const Text("No reviews yet.")
                    : Column(
                        children: _reviews.map((review) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rating: ${review['rating'] ?? 'N/A'}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    review['reviewcomment'] ?? "No comment",
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
          ],
        ),
      ),
    );
  }
}
