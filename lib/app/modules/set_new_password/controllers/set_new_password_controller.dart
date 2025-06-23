import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SetNewPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments["email"];
  }

  void submitPassword() async {
    isLoading.value = true;

    final res = await http.post(
      Uri.parse("https://b007-103-166-147-253.ngrok-free.app/api/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: '{"email": "$email", "new_password": "${passwordController.text}"}',
    );

    isLoading.value = false;

    if (res.statusCode == 200) {
      Get.snackbar("Berhasil", "Password berhasil diubah");
      Get.offAllNamed("/login");
    } else {
      Get.snackbar("Gagal", "Gagal menyimpan password");
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
