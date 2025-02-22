import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

final Dio _dio = Dio();

// Function to get booking information
Future<List<Map<String, dynamic>>> getBookingInfo(userId) async {
  try {
    final response = await _dio.get(
      '$baseUrl/bookinginfo',data: {
        'USERID': lid
      }
    );

    if (response.statusCode == 200) {
      print(response.data);
      // Ensure data is cast correctly
      return (response.data as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to load booking info: ${response.statusMessage}');
    }
  } on DioException catch (e) {
    // Handle Dio errors
    if (e.response != null) {
      throw Exception('Dio error: ${e.response?.statusMessage}');
    } else {
      throw Exception('Error sending request: ${e.message}');
    }
  } catch (e) {
    // Handle other errors
    throw Exception('Unexpected error: $e');
  }
}
