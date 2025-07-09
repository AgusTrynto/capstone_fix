import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../controllers/cameraview_controller.dart';

class CameraviewView extends GetView<CameraviewController> {
  const CameraviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            Center(child: CameraPreview(controller.cameraController)),

            // Baju
            if (controller.bajuOffset.value != null &&
                controller.bajuWidth.value != null &&
                controller.bajuHeight.value != null)
              Positioned(
                left: controller.bajuOffset.value!.dx,
                top: controller.bajuOffset.value!.dy,
                width: controller.bajuWidth.value!,
                height: controller.bajuHeight.value!,
                child: controller.selectedBaju.value.isNotEmpty
                    ? Image.network(controller.selectedBaju.value, fit: BoxFit.cover)
                    : const SizedBox(),
              ),

            // Celana
            if (controller.celanaOffset.value != null &&
                controller.celanaWidth.value != null &&
                controller.celanaHeight.value != null)
              Positioned(
                left: controller.celanaOffset.value!.dx,
                top: controller.celanaOffset.value!.dy,
                width: controller.celanaWidth.value!,
                height: controller.celanaHeight.value!,
                child: controller.selectedCelana.value.isNotEmpty
                    ? Image.network(controller.selectedCelana.value, fit: BoxFit.cover)
                    : const SizedBox(),
              ),

            // ===== ✅ Tombol "Nilai Outfit" =====
            Positioned(
              bottom: 180,
              right: 20,
              child: ElevatedButton.icon(
                onPressed: controller.nilaiOutfit, // panggil ke controller
                icon: const Icon(Icons.check),
                label: const Text("Nilai Outfit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            // Pilihan baju
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.bajuList.length,
                  itemBuilder: (context, index) {
                    final url = controller.bajuList[index];
                    return GestureDetector(
                      onTap: () {
                        controller.selectedBaju.value = url;
                      },
                      child: Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.selectedBaju.value == url ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(url, width: 60, height: 60, fit: BoxFit.cover),
                      )),
                    );
                  },
                ),
              ),
            ),

            // Pilihan celana
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.celanaList.length,
                  itemBuilder: (context, index) {
                    final url = controller.celanaList[index];
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCelana.value = url;
                      },
                      child: Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.selectedCelana.value == url ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(url, width: 60, height: 60, fit: BoxFit.cover),
                      )),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
