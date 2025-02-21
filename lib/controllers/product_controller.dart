import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();
  List<Product> _products = [];
  List<Map<String, dynamic>> _questions = [];

  List<Product> get products => _products;
  List<Map<String, dynamic>> get questions => _questions;

  Future<void> loadProducts() async {
    try {
      _products = await _service.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  Future<void> loadProductsBySubcategory(int? subcategory) async {
    try {
      _products = await _service.getProductsBySubcategory(subcategory);
      notifyListeners();
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final addedProduct = await _service.addProduct(product);
      _products.add(addedProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> removeProduct(int id) async {
    try {
      await _service.removeProduct(id);
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> updateProduct(int id, Product product) async {
    try {
      final updatedProduct = await _service.updateProduct(id, product);
      _products =
          _products.map((p) => p.id == id ? updatedProduct : p).toList();
      notifyListeners();
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> sendRating(int id, int grade) async {
    try {
      await _service.sendRating(id, grade);
      notifyListeners();
    } catch (e) {
      print('Error sending rating: $e');
    }
  }

  Future<void> loadQuestions(int id) async {
    try {
      _questions = await _service.loadQuestions(id);
      notifyListeners();
    } catch (e) {
      print('error loading questions: $e');
    }
  }

  Future<void> sendQuestion(int id, String description) async {
    try {
      await _service.sendQuestion(id, description);
      notifyListeners();
    } catch (e) {
      print('Error sending questions: $e');
    }
  }
}
