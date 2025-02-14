import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:http/http.dart' as http;
import '../models/cart.dart';

class CartRepository {
  final String baseUrl = "http://localhost:8000"; // URL do backend

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

  Future<Cart> fetchCart(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/cart/$userId'),
        headers: await _getHeaders());

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<Cart> addProductToCart(int userId, int productId, int quantity) async {
    final headers = await _getHeaders();

    final response = await http.post(
      Uri.parse('$baseUrl/cart/$userId/add'),
      headers: headers,
      body: jsonEncode({
        "product_id": productId,
        "quantity": quantity,
      }),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add product to cart');
    }
  }

  Future<void> removeProductFromCart(int userId, int productId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/cart/$userId/remove/$productId'),
      headers: await _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove product from cart');
    }
  }
}
