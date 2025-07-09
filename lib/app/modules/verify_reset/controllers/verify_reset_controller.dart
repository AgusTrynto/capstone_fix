import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyResetController extends GetxController {
  final codeController = TextEditingController();
  final isLoading = false.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments["email"];
  }

  void verifyCode() async {
    isLoading.value = true;
    final res = await http.post(
      Uri.parse("https://911292b07b21.ngrok-free.app/api/verify-reset"),
      headers: {"Content-Type": "application/json"},
      body: '{"email": "$email", "code": "${codeController.text}"}',
    );
    isLoading.value = false;

    if (res.statusCode == 200) {
      Get.toNamed('/set-new-password', arguments: {"email": email});
    } else {
      Get.snackbar("Gagal", "Kode OTP salah atau kedaluwarsa");
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
