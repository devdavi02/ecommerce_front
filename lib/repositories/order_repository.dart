import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:http/http.dart' as http;
import '../models/order.dart';

class OrderRepository {
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

  Future<Order> createOrder(int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/order/create?user_id=$userId'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<List<Order>> fetchOrdersByUser(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/user/$userId'),
        headers: await _getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> fetchOrderById(int orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/order/$orderId'),
        headers: await _getHeaders());

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch order');
    }
  }
}
