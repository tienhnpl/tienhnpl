import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fontend/models/dish.dart'; // Thay your_project_name
import 'package:fontend/models/category.dart'; // Thay your_project_name
import 'package:fontend/providers/dish_provider.dart'; // Thay your_project_name
import 'package:fontend/screens/dish_form_screen.dart'; // Thay your_project_name
import 'package:fontend/widgets/dish_list_item.dart'; // Thay your_project_name

class DishListScreen extends StatefulWidget {
  const DishListScreen({super.key});

  @override
  State<DishListScreen> createState() => _DishListScreenState();
}

class _DishListScreenState extends State<DishListScreen> {
  String _searchQuery = '';
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thực đơn Nhà hàng'),
        centerTitle: true,
      ),
      body: Consumer<DishProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.dishes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                'Đã xảy ra lỗi: ${provider.errorMessage}\nVui lòng thử lại!',
                textAlign: TextAlign.center,
              ),
            );
          }

          // Lọc và tìm kiếm
          List<Dish> filteredDishes = provider.dishes.where((dish) {
            final matchesCategory = _selectedCategoryId == null || dish.category?.id == _selectedCategoryId;
            final matchesSearch = _searchQuery.isEmpty || dish.name.toLowerCase().contains(_searchQuery.toLowerCase());
            return matchesCategory && matchesSearch;
          }).toList();

          return RefreshIndicator(
            onRefresh: () => provider.fetchAllData(),
            child: Column(
              children: [
                _buildFilterAndSearch(provider.categories),
                Expanded(
                  child: filteredDishes.isEmpty
                      ? const Center(child: Text('Không tìm thấy món ăn nào.'))
                      : ListView.builder(
                    itemCount: filteredDishes.length,
                    itemBuilder: (ctx, index) => DishListItem(dish: filteredDishes[index]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const DishFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterAndSearch(List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Thanh tìm kiếm
          TextField(
            decoration: InputDecoration(
              labelText: 'Tìm kiếm món ăn...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 8),
          // Bộ lọc danh mục
          DropdownButtonFormField<int?>(
            value: _selectedCategoryId,
            decoration: InputDecoration(
              labelText: 'Lọc theo danh mục',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: [
              const DropdownMenuItem<int?>(
                value: null,
                child: Text('Tất cả danh mục'),
              ),
              ...categories.map((cat) {
                return DropdownMenuItem<int?>(
                  value: cat.id,
                  child: Text(cat.name),
                );
              }).toList(),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCategoryId = value;
              });
            },
          ),
        ],
      ),
    );
  }
}