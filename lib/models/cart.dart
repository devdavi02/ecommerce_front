class CartItem {
  final int id;
  final int productId;
  final String productName; // Nome do produto
  final double productPrice; // Preço do produto
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'quantity': quantity,
    };
  }
}

class Cart {
  final int id;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}
