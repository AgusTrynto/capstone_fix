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
            // Kamera
            Container(
              key: controller.cameraKey,
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(controller.cameraController),
            ),

            // Gambar baju
            if (controller.bajuOffset.value != null &&
                controller.bajuWidth.value != null &&
                controller.bajuHeight.value != null &&
                controller.selectedBaju.value.isNotEmpty)
              Positioned(
                left: controller.bajuOffset.value!.dx - controller.bajuWidth.value! / 2,
                top: controller.bajuOffset.value!.dy - controller.bajuHeight.value! / 2,
                child: Image.network(
                  controller.selectedBaju.value,
                  width: controller.bajuWidth.value,
                  height: controller.bajuHeight.value,
                  fit: BoxFit.fill,
                ),
              ),

            // Gambar celana
            if (controller.celanaOffset.value != null &&
                controller.celanaWidth.value != null &&
                controller.celanaHeight.value != null &&
                controller.selectedCelana.value.isNotEmpty)
              Positioned(
                left: controller.celanaOffset.value!.dx - controller.celanaWidth.value! / 2,
                top: controller.celanaOffset.value!.dy - controller.celanaHeight.value! / 2,
                child: Image.network(
                  controller.selectedCelana.value,
                  width: controller.celanaWidth.value,
                  height: controller.celanaHeight.value,
                  fit: BoxFit.fill,
                ),
              ),

            // Daftar baju dan celana di bawah layar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔹 Baju
                    SizedBox(
                      height: 80,
                      child: Obx(() {
                        if (controller.bajuList.isEmpty) {
                          return const Center(child: Text("Tidak ada baju."));
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.bajuList.length,
                          itemBuilder: (context, index) {
                            final url = controller.bajuList[index];
                            return GestureDetector(
                              onTap: () {
                                controller.selectedBaju.value = url;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: controller.selectedBaju.value == url
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Image.network(url, width: 60, height: 60),
                              ),
                            );
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 10),

                    // 🔸 Celana
                    SizedBox(
                      height: 80,
                      child: Obx(() {
                        if (controller.celanaList.isEmpty) {
                          return const Center(child: Text("Tidak ada celana."));
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.celanaList.length,
                          itemBuilder: (context, index) {
                            final url = controller.celanaList[index];
                            return GestureDetector(
                              onTap: () {
                                controller.selectedCelana.value = url;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: controller.selectedCelana.value == url
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Image.network(url, width: 60, height: 60),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
