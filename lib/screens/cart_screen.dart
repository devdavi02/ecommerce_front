import 'package:ecommerce_front/controllers/order_controller.dart';
import 'package:ecommerce_front/screens/orders_screen.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de Compras"),
      ),
      body: Consumer<CartController>(
        builder: (context, controller, child) {
          if (controller.cartItems.isEmpty) {
            return Center(child: Text("Seu carrinho está vazio"));
          }
          return ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return Card(
                elevation: 4,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  leading: Image.network(
                    "assets/images/user_avatar.webp", // URL real de imagem
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(item.productName), // Nome do produto
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "R\$${item.productPrice.toStringAsFixed(2)}"), // Preço
                      Text("Quantidade: ${item.quantity}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          controller.decreaseQuantity(item);
                        },
                      ),
                      Text("${item.quantity}"),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          controller.increaseQuantity(item);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<OrderController>(context, listen: false)
              .createOrder(AppStorage().getUserId());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Compra finalizda!")),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderListScreen()),
          );
        },
        label: Text("Finalizar Compra"),
        icon: Icon(Icons.payment),
        backgroundColor: Colors.green,
      ),
    );
  }
}
