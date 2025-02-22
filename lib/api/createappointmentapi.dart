import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';
import 'package:predictivehealthcare/homepagescreen.dart';

final Dio dio = Dio();

// Create an appointment
Future<Map<String, dynamic>> createAppointment(
    Map<String, dynamic> appointmentData, context) async {
  final url =
      '$baseUrl/createappointment/$lid'; // API endpoint to create an appointment

  try {
    final response = await dio.post(url, data: appointmentData);
    print("yyuyuyuu$response.data");

    if (response.statusCode == 201) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ));
      print('success');
      return response.data;
    } else {
      throw Exception('Failed to create appointment');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
