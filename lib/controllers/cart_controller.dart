import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../services/cart_service.dart';

class CartController extends ChangeNotifier {
  final CartService _service = CartService();
  Cart? _cart;

  Cart? get cart => _cart;

  List<CartItem> get cartItems => _cart?.items ?? [];

  Future<void> loadCart(int userId) async {
    try {
      _cart = await _service.getCart(userId);
      notifyListeners();
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  Future<void> addProductToCart(int userId, int productId, int quantity) async {
    try {
      _cart = await _service.addProductToCart(userId, productId, quantity);
      notifyListeners();
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }

  Future<void> removeProductFromCart(int userId, int productId) async {
    try {
      await _service.removeProductFromCart(userId, productId);
      _cart?.items.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }

  Future<void> increaseQuantity(CartItem item) async {
    await addProductToCart(AppStorage().getUserId(), item.productId, 1);
  }

  Future<void> decreaseQuantity(CartItem item) async {
    if (item.quantity > 1) {
      await addProductToCart(AppStorage().getUserId(), item.productId, -1);
    } else {
      await removeProductFromCart(AppStorage().getUserId(), item.productId);
    }
  }
}
