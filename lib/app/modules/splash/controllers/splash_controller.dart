import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      final token = box.read('token');
      print('Token: $token'); // Tambahkan ini
      if (token != null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
