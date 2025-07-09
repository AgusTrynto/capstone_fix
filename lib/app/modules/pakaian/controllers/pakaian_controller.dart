import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/pakaian.dart'; // Pastikan path ini sesuai

class PakaianController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ImagePicker picker = ImagePicker();
  final box = GetStorage();

  final String backendUrl = 'https://911292b07b21.ngrok-free.app';

  late TabController tabController;
  late PageController pageController;

  var isLoading = false.obs;
  var selectedTabIndex = 0.obs;

  // Gunakan model Pakaian
  var bajuList = <Pakaian>[].obs;
  var celanaList = <Pakaian>[].obs;

  // Yang terpilih
  var selectedPakaian = <Pakaian>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController(initialPage: 0);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        selectedTabIndex.value = tabController.index;
        pageController.jumpToPage(tabController.index);
        clearSelection();
      }
    });

    fetchPakaian();
  }

  @override
  void onClose() {
    tabController.dispose();
    pageController.dispose();
    super.onClose();
  }

  Future<void> fetchPakaian() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('$backendUrl/pakaian'),
        headers: {
          "Authorization": "Bearer $token",
          "x-api-key": "123",
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final pakaianList = data.map((item) => Pakaian.fromJson(item)).toList();

        bajuList.value = pakaianList.where((e) => e.type == 'baju').toList();
        celanaList.value = pakaianList.where((e) => e.type == 'celana').toList();
      } else {
        Get.snackbar("Error", "Gagal memuat pakaian. (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat memuat.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> tambahPakaian(String type, [String? panjangPendek]) async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;

    isLoading.value = true;

    try {
      final token = box.read('token');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$backendUrl/uploads'),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "x-api-key": "123",
      });

      request.fields['type'] = type;
      if (type == 'celana' && panjangPendek != null) {
        request.fields['panjang_pendek'] = panjangPendek;
      }

      request.files.add(await http.MultipartFile.fromPath('image', photo.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        await fetchPakaian();
        Get.snackbar("Berhasil", "Pakaian berhasil ditambahkan!");
      } else {
        Get.snackbar("Gagal", "Upload gagal. (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat upload.");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelection(Pakaian item) {
    if (selectedPakaian.contains(item)) {
      selectedPakaian.remove(item);
    } else {
      selectedPakaian.add(item);
    }
  }

  void clearSelection() {
    selectedPakaian.clear();
  }

  Future<void> hapusPakaianTerpilih() async {
    if (selectedPakaian.isEmpty) return;

    isLoading.value = true;
    final token = box.read('token');

    try {
      final response = await http.post(
        Uri.parse('$backendUrl/hapus-pakaian'),
        headers: {
          "Authorization": "Bearer $token",
          "x-api-key": "123",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "pakaian_ids": selectedPakaian.map((e) => e.id).toList(),
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Pakaian berhasil dihapus");
        clearSelection();
        fetchPakaian();
      } else {
        Get.snackbar("Gagal", "Gagal menghapus pakaian. (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat menghapus.");
    } finally {
      isLoading.value = false;
    }
  }
}
