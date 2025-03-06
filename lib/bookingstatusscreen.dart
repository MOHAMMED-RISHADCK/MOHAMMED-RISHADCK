import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/viewnotificationapi.dart';
import 'package:predictivehealthcare/viewnotificationscreen.dart';

class BookingStatusScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookingInfo;


  // Mock notification count
  final int _unreadNotifications = 5;

   const BookingStatusScreen({super.key, required this.bookingInfo});
   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Status'),
        backgroundColor: Colors.blueAccent,
      ),
      body: bookingInfo.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: bookingInfo.length,
              itemBuilder: (context, index) {
                final appointment = bookingInfo[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: _getStatusColor(appointment['status']??''),
                    ),
                    title: Text('Doctor: ${appointment['doctor_name']??""}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text('Date: ${appointment['APPOINTMENTDATE']?.toString()??"Not Availible"}'),
                        Text('Time: ${appointment['APPOINTMENTTIME']??"Not Availible"}'),
                      ],
                    ),
                    trailing: Text(
                      appointment['status']??"no",
                      style: TextStyle(
                        color: _getStatusColor(appointment['status']??''),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No Appointments Found',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          FloatingActionButton(
            onPressed: ()async {
              List<Map<String, dynamic>> notificationInfo = await getNotifications();
              // Navigate to the notifications screen or show notifications
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen(notifications: notificationInfo,)),
              );
              _showNotifications(context);
            },
            backgroundColor: Colors.blueAccent,
            child: const Icon(Icons.notifications),
          ),
          if (_unreadNotifications > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  '$_unreadNotifications',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper function to show notifications
  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Text('You have unread notifications!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Helper function to determine status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'approve':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'reject':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
