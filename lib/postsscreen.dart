import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

class MedicalPostsScreen extends StatelessWidget {
  
  final List<dynamic> postData; // Ensure this is a list

  const MedicalPostsScreen({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Posts'),
        backgroundColor: Colors.blueAccent,
      ),
      body: postData.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: postData.length,
              itemBuilder: (context, index) {
                final post = postData[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 6.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${post['category'] ?? 'Unknown Category'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Date: ${post['createdat'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Doctor: ${post['doctor_name'] ?? 'Unknown Doctor'}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          post['title'] ?? 'No Title',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          post['content'] ?? 'No Content Available',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 10),
                        if (post['filepost'] != null && post['filepost'].isNotEmpty)
                          SizedBox(
                            height: 140,
                            width: double.infinity,
                            child: Image.network(
                              '$baseUrl${post['filepost']}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No Posts Found',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
    );
  }
}
