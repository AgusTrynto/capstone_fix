import 'package:capstone/app/modules/cameraview/controllers/cameraview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraviewView extends GetView<CameraviewController> {
  const CameraviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isInitialized.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
        body: Stack(
          children: [
            Container(
              key: controller.cameraKey,
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(controller.cameraController),
            ),
            if (controller.bajuOffset.value != null && controller.bajuWidth.value != null && controller.bajuHeight.value != null)
              Positioned(
                left: controller.bajuOffset.value!.dx - controller.bajuWidth.value! / 2,
                top: controller.bajuOffset.value!.dy - controller.bajuHeight.value! / 2,
                child: Image.asset(
                  'assets/images/baju.png',
                  width: controller.bajuWidth.value,
                  height: controller.bajuHeight.value,
                  fit: BoxFit.fill,
                ),
              ),
          ],
        ),
      );
    });
  }
}
