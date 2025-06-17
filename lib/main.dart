import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart'; // Rute harus terhubung
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Penilaian Outfit',
      initialRoute: Routes.LOGIN, // Ganti ke SplashScreen
      getPages: AppPages.routes, // Pastikan routes di AppPages sudah benar
    );
  }
}
