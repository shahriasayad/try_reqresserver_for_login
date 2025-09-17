import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  void LoginApi() async {
    const String apiKey = 'reqres-free-v1';

    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': apiKey,
        },
        body: jsonEncode({
          'email': emailController.value.text,
          'password': passwordController.value.text,
        }),
      );

      final data = jsonDecode(response.body);
      print(response.statusCode);
      print(data);

      if (response.statusCode == 200) {
        Get.snackbar('Login successful', data['token'] ?? 'No token received');
      } else {
        Get.snackbar('Login failed', data['error'] ?? 'Unknown error');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    }
  }
}
