import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../../pakaian/model/pakaian.dart';

class CameraviewController extends GetxController {
  late CameraController cameraController;
  final isInitialized = false.obs;

  final bajuOffset = Rx<Offset?>(null);
  final bajuWidth = Rx<double?>(null);
  final bajuHeight = Rx<double?>(null);

  final celanaOffset = Rx<Offset?>(null);
  final celanaWidth = Rx<double?>(null);
  final celanaHeight = Rx<double?>(null);

  final cameraKey = GlobalKey();
  late PoseDetector poseDetector;

  final box = GetStorage();
  var isBusy = false;

  var bajuList = <String>[].obs;
  var celanaList = <String>[].obs;

  final celanaInfo = <String, String>{}.obs; // image_url -> panjang_pendek

  var selectedBaju = ''.obs;
  var selectedCelana = ''.obs;

  String? celanaType;

  @override
  void onInit() {
    super.onInit();
    poseDetector = PoseDetector(options: PoseDetectorOptions());
    fetchUserPakaian();
    requestPermission();
  }

Future<void> fetchUserPakaian() async {
  final token = box.read('token');
  if (token == null) return;

  try {
    final response = await http.get(
      Uri.parse('https://5f4df4eb7c85.ngrok-free.app/pakaian'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      final List<Pakaian> pakaianList =
          jsonData.map((item) => Pakaian.fromJson(item)).toList();

      final bajuItems =
          pakaianList.where((item) => item.type == 'baju').toList();
      final celanaItems =
          pakaianList.where((item) => item.type == 'celana').toList();

      bajuList.value = bajuItems.map((e) => e.imageUrl).toList();

      celanaList.clear();
      celanaInfo.clear();
      for (final item in celanaItems) {
        celanaList.add(item.imageUrl);
        celanaInfo[item.imageUrl] = item.panjangPendek;
      }

      if (bajuList.isNotEmpty) selectedBaju.value = bajuList.first;
      if (celanaList.isNotEmpty) {
        selectedCelana.value = celanaList.first;
        celanaType = celanaInfo[selectedCelana.value];
      }
    } else {
      Get.snackbar("Error", "Gagal memuat pakaian.");
    }
  } catch (e) {
    Get.snackbar("Error", "Terjadi kesalahan saat mengambil data.");
  }
}
  void selectCelana(String url) {
    selectedCelana.value = url;
    celanaType = celanaInfo[url];
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
        final leftKnee = pose.landmarks[PoseLandmarkType.leftKnee];
        final rightKnee = pose.landmarks[PoseLandmarkType.rightKnee];

        if (leftShoulder != null &&
            rightShoulder != null &&
            leftHip != null &&
            rightHip != null) {
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

            final shoulderLeft = toScreen(Offset(leftShoulder.x, leftShoulder.y));
            final shoulderRight = toScreen(Offset(rightShoulder.x, rightShoulder.y));
            final hipLeft = toScreen(Offset(leftHip.x, leftHip.y));
            final hipRight = toScreen(Offset(rightHip.x, rightHip.y));
            final kneeLeft = leftKnee != null ? toScreen(Offset(leftKnee.x, leftKnee.y)) : null;
            final kneeRight = rightKnee != null ? toScreen(Offset(rightKnee.x, rightKnee.y)) : null;

            final centerShoulder = Offset(
              (shoulderLeft.dx + shoulderRight.dx) / 2,
              (shoulderLeft.dy + shoulderRight.dy) / 2,
            );
            final centerHip = Offset(
              (hipLeft.dx + hipRight.dx) / 2,
              (hipLeft.dy + hipRight.dy) / 2,
            );

            final centerBaju = Offset(
              (centerShoulder.dx + centerHip.dx) / 2,
              (centerShoulder.dy + centerHip.dy) / 2,
            );

            bajuOffset.value = centerBaju;
            bajuWidth.value = (shoulderLeft.dx - shoulderRight.dx).abs() * 1.2;
            bajuHeight.value = (centerHip.dy - centerShoulder.dy).abs() * 1.3;

            if (kneeLeft != null && kneeRight != null) {
              final centerKnee = Offset(
                (kneeLeft.dx + kneeRight.dx) / 2,
                (kneeLeft.dy + kneeRight.dy) / 2,
              );

              final celanaHeightValue = celanaType == 'pendek'
                  ? (centerKnee.dy - centerHip.dy) * 0.5
                  : (centerKnee.dy - centerHip.dy);

              celanaOffset.value = Offset(
                (hipLeft.dx + hipRight.dx) / 2,
                (hipLeft.dy + hipRight.dy) / 2 + celanaHeightValue / 2,
              );

              celanaWidth.value = (hipLeft.dx - hipRight.dx).abs() * 1.2;
              celanaHeight.value = celanaHeightValue;
            }
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
