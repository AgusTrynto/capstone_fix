import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lupa Password')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.submitEmail,
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Kirim Kode OTP'),
            )),
          ],
        ),
      ),
    );
  }
}
