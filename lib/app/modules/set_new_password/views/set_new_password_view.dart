import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/set_new_password_controller.dart';

class SetNewPasswordView extends GetView<SetNewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buat Password Baru")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Baru',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.submitPassword,
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Simpan Password'),
            )),
          ],
        ),
      ),
    );
  }
}
