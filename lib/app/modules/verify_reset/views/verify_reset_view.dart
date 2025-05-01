import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/verify_reset_controller.dart';

class VerifyResetView extends GetView<VerifyResetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verifikasi Kode OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text("Masukkan 6-digit kode OTP yang dikirim ke ${controller.email}"),
            const SizedBox(height: 20),
            TextField(
              controller: controller.codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'Kode OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.verifyCode,
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Verifikasi'),
            )),
          ],
        ),
      ),
    );
  }
}
