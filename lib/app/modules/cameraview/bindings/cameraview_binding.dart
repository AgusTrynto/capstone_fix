import 'package:get/get.dart';

import '../controllers/cameraview_controller.dart';

class CameraviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraviewController>(
      () => CameraviewController(),
    );
  }
}
