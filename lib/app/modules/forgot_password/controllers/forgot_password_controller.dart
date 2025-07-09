import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void submitEmail() async {
    final email = emailController.text.trim();
    if (email.isEmpty) return;

    isLoading.value = true;

    final res = await http.post(
      Uri.parse('https://911292b07b21.ngrok-free.app/api/request-reset'),
      headers: {'Content-Type': 'application/json'},
      body: '{"email": "$email"}',
    );

    isLoading.value = false;

    if (res.statusCode == 200) {
      Get.toNamed('/verify-reset', arguments: {"email": email});
    } else {
      Get.snackbar('Error', 'Gagal mengirim OTP. Pastikan email terdaftar.');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
