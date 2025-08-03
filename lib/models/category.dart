// TRONG FILE: lib/models/category.dart

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  // --- HÀM fromJson ĐÃ ĐƯỢC VIẾT LẠI ĐỂ ĐỌC CẤU TRÚC JSON PHẲNG ---
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] ?? 'Danh mục không tên',
    );
  }
}