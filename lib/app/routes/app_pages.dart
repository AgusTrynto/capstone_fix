import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
      binding: RegisterBinding()
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding())
    // nanti tambahin halaman Home kalau mau
  ];
}
