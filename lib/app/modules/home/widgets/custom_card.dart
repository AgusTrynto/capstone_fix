import 'package:flutter/material.dart';
import '../../detailpage/views/detailpage_view.dart'; // pastikan path sesuai

class CustomCard extends StatelessWidget {
  final String id;
  final String img;
  final String title;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  const CustomCard({
    Key? key,
    required this.id,
    required this.img,
    required this.title,
    this.isFavorited = false,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                id: id,
                img: img,
                title: title,
                isFavorited: isFavorited,
              ),
            ),
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            img,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
