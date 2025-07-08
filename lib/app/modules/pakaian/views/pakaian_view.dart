import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pakaian_controller.dart';
import '../model/pakaian.dart';

class PakaianView extends GetView<PakaianController> {
  const PakaianView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        appBar: AppBar(
          title: controller.selectedPakaian.isEmpty
              ? const Text("Pakaian Saya")
              : Text("${controller.selectedPakaian.length} dipilih"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          actions: controller.selectedPakaian.isNotEmpty
              ? [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: controller.hapusPakaianTerpilih,
                  ),
                ]
              : [],
          bottom: TabBar(
            controller: controller.tabController,
            labelColor: Colors.white,
            unselectedLabelColor: const Color.fromARGB(255, 180, 179, 179),
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Baju'),
              Tab(text: 'Celana'),
            ],
          ),
        ),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.selectedTabIndex.value = index;
                  controller.tabController.animateTo(index);
                  controller.clearSelection();
                },
                children: [
                  _buildGrid(controller.bajuList),
                  _buildGrid(controller.celanaList),
                ],
              ),
        floatingActionButton: controller.selectedPakaian.isEmpty
            ? FloatingActionButton(
                onPressed: () => _onAddPressed(context),
                backgroundColor: Colors.deepPurple,
                child: const Icon(Icons.add_a_photo, color: Colors.white),
              )
            : null,
      );
    });
  }

  void _onAddPressed(BuildContext context) async {
    final type = controller.selectedTabIndex.value == 0 ? 'baju' : 'celana';

    if (type == 'celana') {
      final panjangPendek = await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pilih Jenis Celana'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'panjang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Panjang'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'pendek'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Pendek'),
                ),
              ],
            ),
          );
        },
      );

      if (panjangPendek != null) {
        controller.tambahPakaian('celana', panjangPendek);
      }
    } else {
      controller.tambahPakaian('baju');
    }
  }

  Widget _buildGrid(List<Pakaian> items) {
    if (items.isEmpty) {
      return const Center(child: Text("Belum ada pakaian."));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = controller.selectedPakaian.contains(item);

        return GestureDetector(
          onLongPress: () => controller.toggleSelection(item),
          onTap: () {
            if (controller.selectedPakaian.isNotEmpty) {
              controller.toggleSelection(item);
            }
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: item.imageUrl.isNotEmpty
                      ? Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.broken_image)),
                        )
                      : const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
              if (isSelected)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.blueAccent,
                    size: 24,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
