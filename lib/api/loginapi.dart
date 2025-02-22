import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:predictivehealthcare/homepagescreen.dart';

final dio = Dio();
int? lid;
String? userType;
String? loginstatus;

const String baseUrl = 'http://192.168.1.106:5000';

Future<void> loginapi(username, password, context) async {
  try {
    final response = await dio.post('$baseUrl/loginapi',data: {
      'username':username,'password':password
    });
    print(response.data);
    int? res = response.statusCode;

    loginstatus = response.data['message'] ?? 'failed';

    if (res == 200 && response.data['message'] == 'success') {
      userType = response.data['type'];
      lid = response.data['login_id'];

    
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
    
    } else {





      print('Login failed');
    }
  } catch (e) {
    print('Error: $e');
  }
}

