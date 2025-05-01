import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpVerificationController extends GetxController {
  final codeController = TextEditingController();
  final isLoading = false.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments["email"]; // Ambil email dari route
  }

  void verifyOtp() async {
    isLoading.value = true;

    final res = await http.post(
      Uri.parse("http://localhost:5000/api/verify-email"),
      headers: {"Content-Type": "application/json"},
      body: '{"email": "$email", "code": "${codeController.text}"}',
    );

    isLoading.value = false;

    if (res.statusCode == 200) {
      Get.snackbar("Sukses", "Email berhasil diverifikasi");
      Get.offAllNamed('/login');
    } else {
      Get.snackbar("Error", "Kode salah atau kedaluwarsa");
    }
  }

  void resendCode() async {
    final res = await http.post(
      Uri.parse("http://localhost:5000/api/request-register"),
      headers: {"Content-Type": "application/json"},
      body: '{"email": "$email", "password": "dummy"}',
    );
    if (res.statusCode == 200) {
      Get.snackbar("Berhasil", "Kode OTP telah dikirim ulang");
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
