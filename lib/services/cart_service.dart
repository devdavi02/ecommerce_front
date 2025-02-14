import '../models/cart.dart';
import '../repositories/cart_repository.dart';

class CartService {
  final CartRepository _repository = CartRepository();

  Future<Cart> getCart(int userId) {
    return _repository.fetchCart(userId);
  }

  Future<Cart> addProductToCart(int userId, int productId, int quantity) {
    return _repository.addProductToCart(userId, productId, quantity);
  }

  Future<void> removeProductFromCart(int userId, int productId) {
    return _repository.removeProductFromCart(userId, productId);
  }
}
