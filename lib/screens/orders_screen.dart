import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/order_controller.dart';

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OrderController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      body: FutureBuilder(
        future: controller.loadOrders(AppStorage()
            .getUserId()), // Certifique-se de passar o userId correto
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar pedidos."));
          }
          return Consumer<OrderController>(
            builder: (context, controller, child) {
              if (controller.orders.isEmpty) {
                return Center(child: Text("Você ainda não fez nenhum pedido."));
              }
              return ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: ExpansionTile(
                      title: Text("Pedido #${order.id}"),
                      subtitle: Text(
                        "Data: ${order.createdAt}\nTotal: R\$${order.id.toStringAsFixed(2)}",
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: order.items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = order.items[itemIndex];
                            return ListTile(
                              leading: Image.network(
                                "assets/images/user_avatar.webp", // URL da imagem do produto
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(item.productName),
                              subtitle: Text(
                                "Quantidade: ${item.quantity}\nPreço: R\$${item.price.toStringAsFixed(2)}",
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
