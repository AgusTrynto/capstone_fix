class Pakaian {
  final String id;
  final String imageUrl;
  final String type; // 'baju' atau 'celana'
  final String panjangPendek; // 'pendek' atau 'panjang'

  Pakaian({
    required this.id,
    required this.imageUrl,
    required this.type,
    required this.panjangPendek,
  });

  factory Pakaian.fromJson(Map<String, dynamic> json) {
    return Pakaian(
      id: json['pakaian_id'],
      imageUrl: json['image_url'],
      type: json['type'],
      panjangPendek: json['panjang_pendek'],
    );
  }
}
