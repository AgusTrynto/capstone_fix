import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/artikel_controller.dart';

class ArtikelView extends GetView<ArtikelController> {
  const ArtikelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> articles = [
      {
        'image': 'assets/images/baju.jpg',
        'title': 'Tren Fashion 2025',
        'description': 'Gaya terbaru tahun ini yang wajib kamu tahu.'
      },
      {
        'image': 'assets/images/baju.jpg',
        'title': 'Tips Memilih Outfit',
        'description': 'Cara memilih pakaian yang sesuai bentuk tubuh.'
      },
      {
        'image': 'assets/images/baju.jpg',
        'title': 'Warna Populer',
        'description': 'Palet warna favorit musim ini.'
      },
      {
        'image': 'assets/images/baju.jpg',
        'title': 'Aksesori Wajib',
        'description': 'Item yang harus ada di lemari kamu.'
      },
      {
        'image': 'assets/images/baju.jpg',
        'title': 'Mix and Match',
        'description': 'Padukan gaya kasual dan formal dengan mudah.'
      },
      {
        'image': 'assets/images/baju.jpg',
        'title': 'Gaya Streetwear',
        'description': 'Inspirasi fashion jalanan yang trendi.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel Fashion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: articles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 kolom
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.55, // Sesuaikan agar tinggi terlihat pas
          ),
          itemBuilder: (context, index) {
            final article = articles[index];
            return ArtikelCard(
              image: article['image']!,
              title: article['title']!,
              description: article['description']!,
            );
          },
        ),
      ),
    );
  }
}

class ArtikelCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const ArtikelCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 12),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
