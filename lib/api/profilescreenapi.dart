import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';


final Dio _dio = Dio();

Future<Map<String, dynamic>> getUserProfile() async {
  try {
    final response = await _dio.get("$baseUrl/user-profile/$lid");
    return response.data;
  } catch (e) {
    print("Error fetching profile: $e");
    return {};
  }
}

