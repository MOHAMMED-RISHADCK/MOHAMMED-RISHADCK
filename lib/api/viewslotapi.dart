import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

final Dio _dio = Dio();
Future<List<Map<String, dynamic>>> getSlots() async {
  try {
    final response =
        await _dio.get('$baseUrl/slotview'); // Adjust the endpoint as needed
    if (response.statusCode == 200) {
      print(response.data);
      return List<Map<String, dynamic>>.from(
          response.data); // Assuming the API returns a JSON array of doctors
    } else {
      throw Exception(
          'Failed to fetch slots. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching slots: $e');
  }
}
