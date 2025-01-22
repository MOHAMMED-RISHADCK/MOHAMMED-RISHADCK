import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';
import 'package:predictivehealthcare/api/viewbookingstatusapi.dart';
import 'package:predictivehealthcare/api/viewdoctorsapi.dart';
import 'package:predictivehealthcare/api/viewpostapi.dart';
import 'package:predictivehealthcare/api/viewprescriptionapi.dart';
import 'package:predictivehealthcare/bookingstatusscreen.dart';
import 'package:predictivehealthcare/chatbotscreen.dart';
import 'package:predictivehealthcare/postsscreen.dart';
import 'package:predictivehealthcare/viewdoctorscreen.dart';
import 'package:predictivehealthcare/viewprescriptionscreen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0288D1), // Medical-themed blue
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFB3E5FC)
            ], // Light blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Welcome, User!",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01579B), // Darker blue for emphasis
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildDashboardItem(
                      icon: Icons.person_search,
                      label: 'Doctors & Appointments',
                      color: const Color(0xFF4CAF50), // Green for health
                      onTap: ()async {
             List<Map<String, dynamic>>doctors=await  getDoctorsList();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AvailableDoctorsScreen(doctors: doctors,)));
                      },
                    ),
                    _buildDashboardItem(
  icon: Icons.calendar_today,
  label: 'Bookings & Notifications',
  color: const Color(0xFF0288D1), // Blue for trust
  onTap: () async {
    // Fetch booking info and notifications
    List<Map<String, dynamic>> bookingInfo = await getBookingInfo(lid);
    

    // Navigate to BookingStatusScreen with the fetched data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingStatusScreen(
          bookingInfo: bookingInfo,
          // notificationInformation: notificationInfo,
        ),
      ),
    );
  },
),


                    _buildDashboardItem(
                      icon: Icons.description,
                      label: 'Prescriptions',
                      color: const Color(0xFF00796B), // Teal for freshness
                      onTap: ()async {
                  List<Map<String,dynamic>>prescriptiondata=await      getPrescriptions();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrescriptionScreen(prescriptions: prescriptiondata,)));
                      },
                    ),
                    _buildDashboardItem(
                      icon: Icons.post_add,
                      label: 'Health Posts',
                      color: const Color(0xFFFFA000), // Orange for engagement
                      onTap: ()async {
                 List<Map<String,dynamic>>postdata=await       getPosts();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalPostsScreen(postdata: postdata,)));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AIChatBotScreen()));
        },
        backgroundColor: const Color(0xFF4CAF50), // Consistent green
        icon: const Icon(Icons.healing, color: Colors.white),
        label: const Text(
          'Disease Prediction',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDashboardItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.white,
            ),
            const SizedBox(height: 12.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
