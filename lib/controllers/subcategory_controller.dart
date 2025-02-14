import 'package:ecommerce_front/models/category.dart';
import 'package:flutter/material.dart';
import '../models/subcategory.dart';
import '../services/subcategory_service.dart';

class SubCategoryController extends ChangeNotifier {
  final SubCategoryService _service = SubCategoryService();
  List<SubCategory> _subcategory = [];

  List<SubCategory> get subcategory => _subcategory;

  // Função para carregar os produtos
  Future<void> loadSubCategory() async {
    try {
      _subcategory = await _service.getSubCategory();
      notifyListeners();
    } catch (e) {
      print('Error loading subcategories: $e');
    }
  }

  Future<List<SubCategory>> fetchSubCategory() async {
    try {
      return await _service
          .getSubCategory(); // Obtém as subcategorias do serviço
    } catch (e) {
      print('Error loading subcategories: $e'); // Imprime o erro no console
      return [];
    }
  }

  Future<List<SubCategory>> fetchSubCategoriesByCategoryId(int id) async {
    try {
      return await _service.getSubcategoryByCategoryId(id);
    } catch (e) {
      print('error loading subcategories');
      return [];
    }
  }

  // Função para adicionar uma nova subcategoria
  Future<void> addSubCategory(SubCategory subcategory) async {
    try {
      final addedSubCategory = await _service.addSubCategory(subcategory);
      _subcategory.add(addedSubCategory);
      notifyListeners();
    } catch (e) {
      print('Error adding subcategory: $e');
    }
  }

  // Função para remover uma subcategria
  Future<void> removeSubCategory(int id) async {
    try {
      await _service.removeSubCategory(id);
      _subcategory.removeWhere((subcategory) => subcategory.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting subcategory: $e');
    }
  }
}
