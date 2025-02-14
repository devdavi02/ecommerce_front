import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoryController extends ChangeNotifier {
  final CategoryService _service = CategoryService();
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  // Função para carregar os produtos
  Future<void> loadCategories() async {
    try {
      _categories = await _service.getCategory();
      notifyListeners();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<List<Category>> fetchCategory() async {
    try {
      return await _service.getCategory(); // Obtém as subcategorias do serviço
    } catch (e) {
      print('Error loading subcategories: $e'); // Imprime o erro no console
      return [];
    }
  }

  // Função para adicionar um novo produto
  Future<void> addCategory(Category category) async {
    try {
      final addedCategory = await _service.addCategory(category);
      _categories.add(addedCategory);
      notifyListeners();
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeCategory(int id) async {
    try {
      await _service.removeCategory(id);
      _categories.removeWhere((category) => category.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting category: $e');
    }
  }
}
