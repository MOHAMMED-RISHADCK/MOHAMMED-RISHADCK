import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart'; // API base URL config

class ReviewApi {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<List<Map<String, dynamic>>> fetchReviews(int doctorId) async {
  try {
    final response = await _dio.get('$baseUrl/getreviews/$doctorId/');

    if (response.statusCode == 200 && response.data is List) {
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      print('Unexpected response format: ${response.data}');
      return [];
    }
  } catch (e) {
    print('Error fetching reviews: $e');
    return [];
  }
}

  static Future<bool> submitReview({
  required int doctorid,
  required double rating,
  required String reviewcomment,
}) async {
  try {
    print('Submitting review for Doctor ID: $doctorid');  // Debug print
    print('Submitting review : $reviewcomment');  // Debug print


    final response = await _dio.post(
      '$baseUrl/addreview/$lid',  // Ensure correct endpoint
      data: {
        'doctor_id': doctorid,  // Correct key
        'rating': rating.toString(),  // Ensure it's a string if needed
        'review': reviewcomment,
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Failed to submit review: ${response.data}');
      return false;
    }
  } on DioException catch (e) {
    print('Dio error: ${e.response?.data ?? e.message}');
    return false;
  } catch (e) {
    print('Unexpected error: $e');
    return false;
  }
}
}