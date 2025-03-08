import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:predictivehealthcare/homepagescreen.dart';

final dio = Dio();
int? lid;
String? userType;
String? loginstatus;

const String baseUrl = 'http://192.168.128.14:5000';

Future<bool> loginapi(String username, String password, BuildContext context) async {
  try {
    final response = await dio.post('$baseUrl/loginapi', data: {
      'username': username,
      'password': password,
    });

    print(response.data);
    int? res = response.statusCode;
    loginstatus = response.data['message'] ?? 'failed';

    if (res == 200 && response.data['message'] == 'success') {
      userType = response.data['type'];
      lid = response.data['login_id'];

      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );

      return true; // ✅ Successfully logged in
    } else {
      print('Login failed');
      return false; // ❌ Login failed
    }
  } catch (e) {
    print('Error: $e');
    return false; // ❌ Login failed due to error
  }
}
