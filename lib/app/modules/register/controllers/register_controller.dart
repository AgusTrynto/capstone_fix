import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  final res = await http.post(
    Uri.parse("http://localhost:5000/api/request-register"),
    headers: {"Content-Type": "application/json"},
    body: '{"email": "$email", "password": "$password"}',
  );

  if (res.statusCode == 200) {
    Get.toNamed(Routes.OTP_VERIFICATION, arguments: {"email": email});
  } else {
    Get.snackbar("Gagal", "Email sudah terdaftar");
  }
}

}
