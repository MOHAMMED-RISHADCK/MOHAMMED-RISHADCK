import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';


  final Dio dio=Dio();
 



  // Create an appointment
  Future<Map<String, dynamic>> createAppointment(Map<String, dynamic> appointmentData) async {
    final url = '$baseUrl/createappointment'; // API endpoint to create an appointment

    try {
      final response = await dio.post(
        url,
        data: json.encode(appointmentData),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        print('success');
        return response.data;
      } else {
        throw Exception('Failed to create appointment');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

