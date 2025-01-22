import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

final Dio _dio = Dio();

Future<List<Map<String, dynamic>>> getDoctorsList() async {
  try {
    final response =
        await _dio.get('$baseUrl/Docview'); // Adjust the endpoint as needed
    if (response.statusCode == 200) {
      print(response.data);
      // Explicitly map each item to a Map<String, dynamic>
      return (response.data as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception(
          'Failed to fetch doctors. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching doctors: $e');
  }
}
