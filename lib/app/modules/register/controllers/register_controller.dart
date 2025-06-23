import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Semua kolom harus diisi");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Password dan Konfirmasi Password tidak cocok");
      return;
    }

    try {
      final res = await http.post(
        Uri.parse("https://873e-103-18-35-77.ngrok-free.app/api/request-register"),
        headers: {
          "Content-Type": "application/json",
          "x-api-key": "123"},
        body: '{"email": "$email", "password": "$password"}',
      );

      if (res.statusCode == 200) {
        Get.toNamed(Routes.OTP_VERIFICATION, arguments: {"email": email});
      } else {
        Get.snackbar("Gagal", "Email atau username sudah terdaftar");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan jaringan");
    }
  }
}
