import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

final Dio _dio = Dio();

Future<List<Map<String, dynamic>>> getNotifications() async {
  try {
    final response = await _dio
        .get('$baseUrl/notificationview'); // Adjust the endpoint as needed
    if (response.statusCode == 200) {
      print(response.data);
      return (response.data as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(); // Assuming the API returns a JSON array of doctors
    } else {
      throw Exception(
          'Failed to fetch notifications. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching notifications: $e');
  }
}
