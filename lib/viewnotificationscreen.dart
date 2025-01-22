import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

class NotificationScreen extends StatelessWidget {
  final notifications;
  // Mock notification data
  // final List<Map<String, String>> _notifications = [
  //   {
  //     'title': 'Appointment Confirmed',
  //     'description':
  //         'Your appointment with Dr. Alice is confirmed for 2024-12-28 at 10:00 AM.',
  //     'date': '2024-12-27',
  //   },
  //   {
  //     'title': 'Appointment Pending',
  //     'description':
  //         'Your appointment with Dr. Bob is pending confirmation for 2024-12-29 at 03:00 PM.',
  //     'date': '2024-12-26',
  //   },
  //   {
  //     'title': 'Appointment Cancelled',
  //     'description':
  //         'Your appointment with Dr. Carol on 2024-12-30 at 02:00 PM has been cancelled.',
  //     'date': '2024-12-25',
  //   },
  // ];

   const NotificationScreen({super.key, this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body:  notifications.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      notification['content']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        notification['attachement']!=null?Image.network('$baseUrl${notification['attachement']}'):SizedBox(),
                        // Text(notification['description']!),
                        // const SizedBox(height: 4.0),
                        Text(
                          'Date: ${notification['createdat']}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12.0,
                            color: Colors.grey,
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
                'No Notifications Found',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
    );
  }
}
