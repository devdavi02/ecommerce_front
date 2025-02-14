import '../models/order.dart';
import '../repositories/order_repository.dart';

class OrderService {
  final OrderRepository _repository = OrderRepository();

  Future<Order> createOrder(int userId) {
    return _repository.createOrder(userId);
  }

  Future<List<Order>> getOrdersByUser(int userId) {
    return _repository.fetchOrdersByUser(userId);
  }

  Future<Order> getOrderById(int orderId) {
    return _repository.fetchOrderById(orderId);
  }
}
