// lib/models/place_model.dart

import 'dart:convert';

// Hàm này không cần thay đổi
List<Place> placeFromJson(String str) =>
    List<Place>.from(json.decode(str)["data"].map((x) => Place.fromJson(x)));

class Place {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;

  Place({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
  });

  // ===== THAY THẾ TOÀN BỘ HÀM NÀY =====
  factory Place.fromJson(Map<String, dynamic> json) {
    const String strapiBaseUrl = "http://10.0.2.2:1337";
    String imageUrl = "https://via.placeholder.com/150.png?text=No+Image";

    // XỬ LÝ CẤU TRÚC JSON MỚI
    // 1. Kiểm tra khóa 'image' (thay vì 'imageUrl') và nó là một danh sách (List)
    if (json['image'] != null && (json['image'] as List).isNotEmpty) {
      // 2. Lấy object đầu tiên trong danh sách ảnh đó
      final imageData = (json['image'] as List).first;

      // 3. URL nằm ngay trong object đó, không cần đi sâu vào "attributes"
      if (imageData['url'] != null) {
        imageUrl = "$strapiBaseUrl${imageData['url']}";
      }
    }

    return Place(
      id: json['id'],
      // 4. Lấy dữ liệu trực tiếp từ json, không cần thông qua "attributes" nữa
      name: json['name'] ?? 'No Name',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: imageUrl,
    );
  }
// ===== KẾT THÚC PHẦN THAY THẾ =====
}