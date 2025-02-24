import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';
import 'package:predictivehealthcare/api/viewbookingstatusapi.dart';
import 'package:predictivehealthcare/api/viewdoctorsapi.dart';
import 'package:predictivehealthcare/api/viewpostapi.dart';
import 'package:predictivehealthcare/api/viewprescriptionapi.dart';
import 'package:predictivehealthcare/bookingstatusscreen.dart';
import 'package:predictivehealthcare/chatbotscreen.dart';
import 'package:predictivehealthcare/postsscreen.dart';
import 'package:predictivehealthcare/profilescreen.dart';
import 'package:predictivehealthcare/viewdoctorscreen.dart';
import 'package:predictivehealthcare/viewprescriptionscreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Predictive Healthcare',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0288D1), // Medical-themed blue
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Open the drawer when the menu button is tapped
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Profile link at the top
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // Handle profile tap (you can navigate to a profile screen here)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            const Divider(),
            // Other menu items can go here
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings tap
                // For
              },
            ),
            const Divider(),
            // Logout button at the bottom
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout action
                // For now, just show a snackbar (you can add real logout logic here)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
                // You can also clear user data, navigate to login screen, etc.
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFB3E5FC),
            ],
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
                  color: Color(0xFF01579B),
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
                      color: const Color(0xFF4CAF50),
                      onTap: () async {
                        List<Map<String, dynamic>> doctors = await getDoctorsList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AvailableDoctorsScreen(doctors: doctors),
                          ),
                        );
                      },
                    ),
                    _buildDashboardItem(
                      icon: Icons.calendar_today,
                      label: 'Bookings & Notifications',
                      color: const Color(0xFF0288D1),
                      onTap: () async {
                        List<Map<String, dynamic>> bookingInfo = await getBookingInfo(lid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingStatusScreen(
                              bookingInfo: bookingInfo,
                            ),
                          ),
                        );
                      },
                    ),
                    _buildDashboardItem(
                      icon: Icons.description,
                      label: 'Prescriptions',
                      color: const Color(0xFF00796B),
                      onTap: () async {
                        List<Map<String, dynamic>> prescriptionData = await getPrescriptions();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrescriptionScreen(prescriptions: prescriptionData),
                          ),
                        );
                      },
                    ),
                    _buildDashboardItem(
                      icon: Icons.post_add,
                      label: 'Health Posts',
                      color: const Color(0xFFFFA000),
                      onTap: () async {
                        List<Map<String, dynamic>> postData = await getPosts();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicalPostsScreen(postData: postData),
                          ),
                        );
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
        backgroundColor: const Color(0xFF4CAF50),
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


