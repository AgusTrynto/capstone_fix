import 'package:get/get.dart';

import '../controllers/verify_reset_controller.dart';

class VerifyResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyResetController>(
      () => VerifyResetController(),
    );
  }
}
