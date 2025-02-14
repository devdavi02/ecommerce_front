import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class OrderController extends ChangeNotifier {
  final OrderService _service = OrderService();
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> loadOrders(int userId) async {
    try {
      _orders = await _service.getOrdersByUser(userId);
      notifyListeners();
    } catch (e) {
      print('Error loading orders: $e');
    }
  }

  Future<void> createOrder(int userId) async {
    try {
      await _service.createOrder(userId);
      await loadOrders(userId); // Recarrega os pedidos após criar um novo
    } catch (e) {
      print('Error creating order: $e');
    }
  }
}
