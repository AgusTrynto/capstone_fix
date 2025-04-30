import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Simulasi berhasil daftar
      Get.snackbar("Registrasi Berhasil", "Silakan login.");
      Get.offNamed('/login');
    } else {
      Get.snackbar("Error", "Email dan password harus diisi");
    }
  }
}
