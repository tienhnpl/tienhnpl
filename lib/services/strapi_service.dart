import 'dart:convert';
import 'dart:io';
// --- DÒNG QUAN TRỌNG ĐÃ ĐƯỢC SỬA LẠI ĐÚNG ---
import 'package:http/http.dart' as http;
// !!! THAY 'fontend' BẰNG TÊN PROJECT CỦA BẠN NẾU KHÁC !!!
import 'package:fontend/models/dish.dart';
import 'package:fontend/models/category.dart';

class StrapiService {
  static const String _baseUrl = "http://10.0.2.2:1337";

  String getImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'https://via.placeholder.com/400x300.png?text=No+Image';
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return _baseUrl + url;
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/categories'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final List<dynamic> categoryList;

      if (decodedData is Map<String, dynamic> && decodedData.containsKey('data')) {
        categoryList = decodedData['data'];
      } else if (decodedData is List) {
        categoryList = decodedData;
      } else {
        throw Exception('Unexpected JSON format for categories');
      }

      return categoryList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Dish>> getDishes() async {
    // Thử với ?populate=* để đảm bảo lấy được cả category nếu có
    final response = await http.get(Uri.parse('$_baseUrl/api/dishes?populate=*'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final List<dynamic> dishList;

      if (decodedData is Map<String, dynamic> && decodedData.containsKey('data')) {
        dishList = decodedData['data'];
      } else if (decodedData is List) {
        dishList = decodedData;
      } else {
        throw Exception('Unexpected JSON format for dishes');
      }

      return dishList.map((json) => Dish.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  Future<void> deleteDish(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/api/dishes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete dish');
    }
  }

  Future<void> createOrUpdateDish({
    required String name,
    required String description,
    required double price,
    required int categoryId,
    File? imageFile,
    int? dishId,
  }) async {
    // Chức năng này sẽ cần được điều chỉnh tùy vào phiên bản Strapi v3 hay v4
    // Tạm thời để trống để tập trung vào việc hiển thị
    print("Create/Update function needs to be adapted for your Strapi version.");
  }
}