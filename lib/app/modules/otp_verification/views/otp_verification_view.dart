import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verifikasi Email")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Kode OTP',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Kami telah mengirim 6-digit kode ke email kamu (${controller.email})',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: controller.codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'Kode OTP',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.verifyOtp,
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Verifikasi'),
              ),
            )),
            const SizedBox(height: 10),
            TextButton(
              onPressed: controller.resendCode,
              child: Text('Kirim Ulang Kode'),
            ),
          ],
        ),
      ),
    );
  }
}
