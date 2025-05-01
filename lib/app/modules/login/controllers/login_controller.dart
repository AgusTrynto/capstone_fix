import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final box = GetStorage();

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        box.write('token', data['token']);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Login Gagal", data['message'] ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
    }
  }
}
