// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

Future<void> chatbotApi(String data,context) async {
  try {
    final response = await Dio().post('$baseUrl/chatbotapi',
        data: data);
    print(response.data);
    int? res = response.statusCode;
    print(res);

    if (res == 201) {
      print('Registration Successful');
      Navigator.pop(context);
    } else {
      print('Registration failed');
    }
  } catch (e) {
    print(e);
  }
}
