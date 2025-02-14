class OrderItem {
  final int id;
  final int productId;
  final String productName;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class Order {
  final int id;
  final String createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      createdAt: json['created_at'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}
