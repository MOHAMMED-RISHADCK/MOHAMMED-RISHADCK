import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';  // Make sure to import dio

// Assuming you have a Dio instance
final dio = Dio();
  // Replace with your actual base URL

// Function to handle API call for password reset
Future<void> resetPassword(String email) async {
  final url = '$baseUrl/forgot-password';  // The URL for your Django API

  try {
    // Sending POST request to the backend with the email
    final response = await dio.post(
      url,
      data: {'email': email},  // Using 'data' instead of 'body' for Dio
    );

    // Handling response
    if (response.statusCode == 200) {
      // Success - Password reset link sent
      print('Password reset link sent to $email');
    } else {
      // Failure - Something went wrong
      print('Error: ${response.data}');
    }
  } catch (e) {
    // Handle any errors like no internet connection
    print('Failed to send password reset link. Please try again later. Error: $e');
  }
}
