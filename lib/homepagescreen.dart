import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/viewbookingstatusapi.dart';
import 'package:predictivehealthcare/api/viewdoctorsapi.dart';
import 'package:predictivehealthcare/api/viewpostapi.dart';
import 'package:predictivehealthcare/api/viewprescriptionapi.dart';
import 'package:predictivehealthcare/bookingstatusscreen.dart';
import 'package:predictivehealthcare/chatbotscreen.dart';
import 'package:predictivehealthcare/login.dart';
import 'package:predictivehealthcare/postsscreen.dart';
import 'package:predictivehealthcare/profilescreen.dart';
import 'package:predictivehealthcare/viewdoctorscreen.dart';
import 'package:predictivehealthcare/viewprescriptionscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Predictive Healthcare',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.teal,
        elevation: 5,
        shadowColor: Colors.black45,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("User Name"),
              accountEmail: const Text("user@example.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.blueAccent),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            _buildDrawerItem(Icons.account_circle, "Profile", context, ProfileScreen()),
            _buildDrawerItem(Icons.settings, "Settings", context, null),
            const Divider(),
            _buildDrawerItem(Icons.exit_to_app, "Logout", context, null, _logout),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
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
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildDashboardItem(Icons.person_search, "Doctors", Colors.green, () async {
                      List<Map<String, dynamic>> doctors = await getDoctorsList();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AvailableDoctorsScreen(doctors: doctors)));
                    }),
                    _buildDashboardItem(Icons.calendar_today, "Bookings", Colors.blue, () async {
                      List<Map<String, dynamic>> bookingInfo = await getBookingInfo(1);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingStatusScreen(bookingInfo: bookingInfo)));
                    }),
                    _buildDashboardItem(Icons.description, "Prescriptions", Colors.teal, () async {
                      List<Map<String, dynamic>> prescriptionData = await getPrescriptions();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionScreen(prescriptions: prescriptionData)));
                    }),
                    _buildDashboardItem(Icons.post_add, "Health Posts", Colors.orange, () async {
                      List<Map<String, dynamic>> postData = await getPosts();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalPostsScreen(postData: postData)));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AIChatBotScreen()));
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.healing, color: Colors.white),
        label: const Text(
          'Disease Prediction',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDashboardItem(IconData icon, String label, Color color, VoidCallback onTap) {
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
            Icon(icon, size: 50.0, color: Colors.white),
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

  Widget _buildDrawerItem(IconData icon, String label, BuildContext context, Widget? screen, [Function(BuildContext)? customAction]) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label, style: const TextStyle(fontSize: 16.0)),
      onTap: () {
        if (customAction != null) {
          customAction(context);
        } else if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        }
      },
    );
  }
}