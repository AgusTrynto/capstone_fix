import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraviewController extends GetxController {
  late CameraController cameraController;
  final isInitialized = false.obs;

  final bajuOffset = Rx<Offset?>(null);
  final bajuWidth = Rx<double?>(null);
  final bajuHeight = Rx<double?>(null);

  final cameraKey = GlobalKey();
  late PoseDetector poseDetector;

  var isBusy = false;

  @override
  void onInit() {
    super.onInit();
    poseDetector = PoseDetector(options: PoseDetectorOptions());
    requestPermission();
  }

  void requestPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      initCamera();
    } else {
      debugPrint("Izin kamera tidak diberikan");
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(
      cameras.firstWhere((cam) => cam.lensDirection == CameraLensDirection.back),
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await cameraController.initialize();
    cameraController.startImageStream(_processImage);
    isInitialized.value = true;
  }

  void _processImage(CameraImage image) async {
    if (isBusy) return;
    isBusy = true;

    try {
      final allBytes = <int>[];
      for (final plane in image.planes) {
        allBytes.addAll(plane.bytes);
      }
      final bytes = Uint8List.fromList(allBytes);

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: image.planes.first.bytesPerRow,
        ),
      );
      final poses = await poseDetector.processImage(inputImage);
      if (poses.isNotEmpty) {
        final pose = poses.first;

        final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
        final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
        final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
        final rightHip = pose.landmarks[PoseLandmarkType.rightHip];

        if (leftShoulder != null && rightShoulder != null && leftHip != null && rightHip != null) {
          final screenSize = cameraKey.currentContext?.size;

          if (screenSize != null) {
            final cameraSize = Size(image.width.toDouble(), image.height.toDouble());
            double scaleX = screenSize.width / cameraSize.height;
            double scaleY = screenSize.height / cameraSize.width;

            Offset toScreen(Offset input) {
              return Offset(
                screenSize.width - (input.dy * scaleX),
                input.dx * scaleY,
              );
            }

            final left = toScreen(Offset(leftShoulder.x, leftShoulder.y));
            final right = toScreen(Offset(rightShoulder.x, rightShoulder.y));
            final hipLeft = toScreen(Offset(leftHip.x, leftHip.y));
            final hipRight = toScreen(Offset(rightHip.x, rightHip.y));

            final centerShoulder = Offset((left.dx + right.dx) / 2, (left.dy + right.dy) / 2);
            final centerHip = Offset((hipLeft.dx + hipRight.dx) / 2, (hipLeft.dy + hipRight.dy) / 2);
            final centerBody = Offset(
              (centerShoulder.dx + centerHip.dx) / 2,
              (centerShoulder.dy + centerHip.dy) / 2,
            );

            bajuOffset.value = centerBody;
            bajuWidth.value = (left.dx - right.dx).abs() * 1.2;
            bajuHeight.value = (centerHip.dy - centerShoulder.dy).abs() * 1.3;
          }
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isBusy = false;
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    poseDetector.close();
    super.onClose();
  }
}
