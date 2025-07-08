import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final box = GetStorage();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://5f4df4eb7c85.ngrok-free.app/api/login'),
        headers: {"Content-Type": "application/json", "x-api-key": "123"},
        body: json.encode({"email": email, "password": password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        box.write('token', data['token']);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Login Gagal", data['message'] ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
    }
  }

  void loginWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // Paksa pemilihan akun lagi

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in ke Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        Get.snackbar("Error", "Gagal mendapatkan ID Token");
        return;
      }

      final response = await http.post(
        Uri.parse('https://5f4df4eb7c85.ngrok-free.app/api/google-login'),
        headers: {"Content-Type": "application/json", "x-api-key": "123"},
        body: json.encode({"idToken": idToken}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        box.write('token', data['token']);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Login Gagal", data['error'] ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal login dengan Google: ${e.toString()}");
    }
  }
}
