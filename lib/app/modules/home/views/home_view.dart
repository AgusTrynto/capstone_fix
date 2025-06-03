import 'package:flutter/material.dart';
import '../widgets/custom_card.dart'; // sesuaikan path
import '../../artikel/views/artikel_view.dart';
import '../../favorite/views/favorite_view.dart';
import '../../profile/views/profile_view.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> outfits = [
    {
      'id': '1',
      'img': 'assets/images/baju.jpg',
      'title': 'Outfit Kasual',
      'isFavorited': false,
    },
    {
      'id': '2',
      'img': 'assets/images/baju.jpg',
      'title': 'Outfit Formal',
      'isFavorited': true,
    },
    {
      'id': '3',
      'img': 'assets/images/baju.jpg',
      'title': 'Outfit Sporty',
      'isFavorited': false,
    },
  ];

  void toggleFavorite(String id) {
    setState(() {
      final index = outfits.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        outfits[index]['isFavorited'] = !outfits[index]['isFavorited'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'Beranda',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, selamat datang! 👋',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Mulai nilai outfit atau baca tips fashion terkini!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: outfits.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = outfits[index];
                    return CustomCard(
                      id: item['id'],
                      img: item['img'],
                      title: item['title'],
                      isFavorited: item['isFavorited'],
                      onFavoriteToggle: () => toggleFavorite(item['id']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Buka Kamera!');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                color: Colors.black87,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.article_outlined),
                color: Colors.black54,
                onPressed: () => Get.to(() => const ArtikelView()),
              ),
              const SizedBox(width: 40), // spasi tengah
              IconButton(
                icon: const Icon(Icons.favorite_border),
                color: Colors.black54,
                onPressed: () => Get.to(() => const FavoriteView()),
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                color: Colors.black54,
                onPressed: () => Get.to(() => const ProfileView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
