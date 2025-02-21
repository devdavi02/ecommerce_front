import 'dart:convert';
import 'package:ecommerce_front/main.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  final String baseUrl = "http://localhost:8000";

  Future<Map<String, String>> _getHeaders() async {
    final token = AppStorage.instance.token;
    if (token != null) {
      return {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    }
    return {"Content-Type": "application/json"};
  }

  void _handleUnauthorized() {
    AppStorage.instance.removeToken(); // Remove o token inválido
    MyApp.navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<Product> fechProductById(int id) async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/product/$id'), headers: headers);

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/products'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Product.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchProductsBySubcategory(int? subcategoryId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/products/subcategory/$subcategoryId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Product.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> createProduct(Product product) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/product/save'),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to create product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final headers = await _getHeaders();
    final response =
        await http.delete(Uri.parse('$baseUrl/product/$id'), headers: headers);

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to delete product');
    }
  }

  Future<Product> updateProduct(int id, Product product) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/product/$id'),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return fechProductById(id);
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> sendRating(int id, int grade) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/product/classification/$id/$grade'),
      headers: headers,
      // body: jsonEncode({"product_id": id,
      //   "grade": grade}),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to send rating');
    }
  }

  // Busca perguntas do backend
  Future<List<Map<String, dynamic>>> fetchProductQuestions(int productId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/question/answer/$productId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // Envia uma nova pergunta para o backend
  Future<void> sendQuestion(int productId, String description) async {

    final body = jsonEncode({
    "description": description, 
    "product_id": productId
  });

    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/question/save/'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to send question');
    }
  }
}
