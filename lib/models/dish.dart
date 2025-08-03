// TRONG FILE: lib/models/dish.dart

import 'package:fontend/models/category.dart'; // Thay 'fontend' bằng tên project của bạn

class Dish {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final Category? category;

  Dish({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.category,
  });

  // --- HÀM fromJson ĐÃ ĐƯỢC VIẾT LẠI HOÀN TOÀN ĐỂ ĐỌC CẤU TRÚC JSON PHẲNG ---
  factory Dish.fromJson(Map<String, dynamic> json) {
    // Lấy dữ liệu image một cách an toàn từ cấu trúc phẳng
    String? finalImageUrl;
    if (json['image'] != null && json['image'] is Map) {
      // Ưu tiên lấy URL từ trường 'url' bên trong 'image'
      if (json['image']['url'] != null) {
        finalImageUrl = json['image']['url'];
      }
    } else if (json['image_url'] != null) {
      // Nếu có trường image_url riêng thì lấy từ đó
      finalImageUrl = json['image_url'];
    }

    return Dish(
      id: json['id'],
      name: json['name'] ?? 'Món không tên',
      description: json['description'] ?? '',
      price: (json['price'] as num? ?? 0.0).toDouble(),
      // Lấy dữ liệu category từ cấu trúc phẳng (nếu có)
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      imageUrl: finalImageUrl,
    );
  }
}