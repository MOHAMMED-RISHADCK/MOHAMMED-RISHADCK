import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

class MedicalPostsScreen extends StatelessWidget {
  // Mock posts data
  final postData;
  // final List<Map<String, String>> _posts = [
  //   {
  //     'doctor': 'Dr. Alice',
  //     'title': 'Tips for a Healthy Heart',
  //     'content':
  //         'Regular exercise, a balanced diet, and adequate sleep are crucial for maintaining heart health.',
  //     'date': '2024-12-28',
  //   },
  //   {
  //     'doctor': 'Dr. Bob',
  //     'title': 'Managing Diabetes',
  //     'content':
  //         'Keep your blood sugar levels in check with proper medication, a low-carb diet, and regular monitoring.',
  //     'date': '2024-12-26',
  //   },
  //   {
  //     'doctor': 'Dr. Carol',
  //     'title': 'The Importance of Vaccination',
  //     'content':
  //         'Vaccination is vital for preventing diseases. Always stay updated with your immunization schedule.',
  //     'date': '2024-12-25',
  //   },
  // ];

  const MedicalPostsScreen({super.key, this.postData});

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
                            // const Icon(
                            //   Icons.person,
                            //   size: 36.0,
                            //   color: Colors.blueAccent,
                            // ),
                            // const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${post['category']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Date: ${post['createdat']}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          post['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          post['content']!,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 140,
                          width: double.infinity,
                          child: Image.network('$baseUrl${post['filepost']}',fit: BoxFit.fill,),
                        )
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
