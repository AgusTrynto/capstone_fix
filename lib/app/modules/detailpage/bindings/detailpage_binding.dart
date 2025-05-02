import 'package:get/get.dart';

import '../controllers/detailpage_controller.dart';

class DetailpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailpageController>(
      () => DetailpageController(),
    );
  }
}
