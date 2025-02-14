import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import 'product_details_screen.dart';

class ProductListScreenClient extends StatelessWidget {
  int? subcategoryId;

  ProductListScreenClient({super.key, required this.subcategoryId}) {
    subcategoryId = subcategoryId;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context, listen: false);

    if (subcategoryId != null) {
      controller.loadProductsBySubcategory(subcategoryId);
    } else {
      controller.loadProducts();
    }

    return Consumer<ProductController>(
      builder: (context, controller, child) {
        if (controller.products.isEmpty) {
          return Center(child: Text("Nenhum produto disponível"));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, // Largura máxima de cada card
            crossAxisSpacing: 8.0, // Espaçamento horizontal entre os cards
            mainAxisSpacing: 8.0, // Espaçamento vertical entre os cards
            childAspectRatio: 0.7, // Ajusta a proporção entre largura e altura
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagem do produto
                    AspectRatio(
                      aspectRatio: 1, // Imagem quadrada
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          "assets/images/user_avatar.webp",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Detalhes do produto
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "R\$${product.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
