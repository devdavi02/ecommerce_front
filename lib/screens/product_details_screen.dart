import 'package:ecommerce_front/controllers/cart_controller.dart';
import 'package:ecommerce_front/controllers/product_controller.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth =
                constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
            return SingleChildScrollView(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagem do produto
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          "assets/images/user_avatar.webp",
                          width: double.infinity,
                          height: 400, // Altura aumentada para mais retangular
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Informações do produto
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "R\$${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Subcategoria: ${product.subCategory.name}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Formas de pagamento: Cartão, Boleto, Pix",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                SizedBox(width: 4),
                                Text(
                                  "${product.average}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                
                              ],
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: product
                                      .average, // Pega a média atual do produto
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    Provider.of<ProductController>(context,
                                            listen: false)
                                        .sendRating(
                                            product.id,
                                            rating
                                                .toInt()); // Envia a avaliação como um número inteiro
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Provider.of<CartController>(context,
                                          listen: false)
                                      .addProductToCart(
                                          AppStorage().getUserId(),
                                          product.id,
                                          1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Produto adicionado ao carrinho!")),
                                  );
                                },
                                icon: Icon(Icons.shopping_cart),
                                label: Text("Adicionar ao Carrinho"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
