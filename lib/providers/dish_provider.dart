import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fontend/services/strapi_service.dart';
import 'package:fontend/models/category.dart';
import 'package:fontend/models/dish.dart';

class DishProvider with ChangeNotifier {
  final StrapiService _strapiService = StrapiService();

  List<Dish> _dishes = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Dish> get dishes => _dishes;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  DishProvider() {
    fetchAllData();
  }

  String getImageUrl(String? relativeUrl) => _strapiService.getImageUrl(relativeUrl);

  Future<void> fetchAllData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Chạy song song để tiết kiệm thời gian
      final results = await Future.wait([
        _strapiService.getDishes(),
        _strapiService.getCategories(),
      ]);
      _dishes = results[0] as List<Dish>;
      _categories = results[1] as List<Category>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteDish(int id) async {
    try {
      await _strapiService.deleteDish(id);
      _dishes.removeWhere((dish) => dish.id == id);
      notifyListeners();
    } catch (e) {
      // Xử lý lỗi ở đây, ví dụ hiển thị SnackBar
      print("Error deleting dish: $e");
      rethrow; // Ném lại lỗi để UI có thể bắt
    }
  }

  Future<void> saveDish({
    required String name,
    required String description,
    required double price,
    required int categoryId,
    File? imageFile,
    int? dishId,
  }) async {
    await _strapiService.createOrUpdateDish(
      name: name,
      description: description,
      price: price,
      categoryId: categoryId,
      imageFile: imageFile,
      dishId: dishId,
    );
    // Sau khi lưu thành công, tải lại toàn bộ dữ liệu để đảm bảo đồng bộ
    await fetchAllData();
  }
}