import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/artikel_controller.dart';

class ArtikelView extends GetView<ArtikelController> {
  const ArtikelView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Artikel Fashion',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: articles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Lebih proporsional
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
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
    final theme = Theme.of(context);

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // TODO: Buka detail artikel jika ada
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[700],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
