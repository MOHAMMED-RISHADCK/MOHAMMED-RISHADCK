import 'package:flutter/material.dart';
import 'package:predictivehealthcare/createappointment.dart';
import 'package:predictivehealthcare/reviewandratescreen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;
  // final List<Map<String,dynamic>> slottt;

  const DoctorDetailsScreen(
      {super.key, required this.doctor,});

  @override
  Widget build(BuildContext context) {
    // Mock reviews data
    final List<Map<String, String>> reviews = [
      {'review': 'Excellent doctor, very professional!', 'rating': '5.0'},
      {'review': 'Great experience. Highly recommend.', 'rating': '4.5'},
    ];

    // Calculate average rating
    double averageRating = 0;
    if (reviews.isNotEmpty) {
      averageRating = reviews
              .map((review) => double.parse(review['rating']!))
              .reduce((a, b) => a + b) /
          reviews.length;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor['name'] ?? 'Doctor Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor's Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: doctor['imageUrl'] != null &&
                          doctor['imageUrl']!.isNotEmpty
                      ? Image.network(
                          doctor['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/doc3.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/images/doc3.jpg',
                          width: 50,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 16),
                // Doctor Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['Name'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        doctor['specialization'] ?? 'N/A',
                        style:
                            const TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${doctor['qualification'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(Icons.star, color: Colors.amber, size: 20.0),
                          Text(
                            doctor['rating']?.toStringAsFixed(1) ?? '0.0',
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
            const Text(
              'Select Appointment Date',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Date Picker Section
            ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {


                  // Navigate to the Create Appointment screen with the selected date
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAppointmentScreen(
                        selectedDate: selectedDate,
                        doctorid: doctor["id"],
                      ),
                    ),
                  );
                }
              },
              child: const Text('Pick a Date for Appointment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            const Divider(height: 30),

            // Reviews Section
            const SizedBox(height: 24),
            const Text(
              'Doctor Reviews & Ratings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Display average rating
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20.0),
                Text(
                  averageRating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${reviews.length} reviews)',
                  style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // List reviews
            for (var review in reviews)
              Padding(
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
                        'Rating: ${review['rating']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review['review']!,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),

            const Divider(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to review screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewAndRatingScreen(
                        doctor: doctor,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.reviews),
                label: const Text('Add Review'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
