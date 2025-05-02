import 'package:flutter/material.dart';
import '../widgets/custom_card.dart'; // sesuaikan path
import '../../artikel/views/artikel_view.dart'; // sesuaikan path
import 'package:get/get.dart';
import '../../favorite/views/favorite_view.dart'; // sesuaikan path
import '../../profile/views/profile_view.dart'; // sesuaikan path

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Home',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, selamat datang!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Mulai nilai outfit atau baca tips fashion terkini!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: outfits.length,
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
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.home), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.note),
                onPressed: () {
                  Get.to(() => const ArtikelView());
                },
              ),

              const SizedBox(width: 40), // spasi untuk kamera
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Get.to(() => const FavoriteView());
                  },
                ),
                 IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Get.to(() => const ProfileView());
                  },
        ),
            ],
          ),
        ),
      ),
    );
  }
}
