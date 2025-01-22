import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

final Dio _dio = Dio();
Future<List<Map<String, dynamic>>> getPosts() async {
  try {
    final response =
        await _dio.get('$baseUrl/postview'); // Adjust the endpoint as needed
    if (response.statusCode == 200) {
      print(response.data);
      return List<Map<String, dynamic>>.from(
          response.data); // Assuming the API returns a JSON array of doctors
    } else {
      throw Exception(
          'Failed to fetch posts. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching posts: $e');
  }
}
