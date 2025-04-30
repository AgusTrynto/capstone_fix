import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email == "agus@gmail.com" && password == "123456") {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Login Gagal", "Email atau password salah");
    }
  }
}
