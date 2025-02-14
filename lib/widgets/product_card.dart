import 'package:ecommerce_front/screens/add_product_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';


// Widget que exibe os detalhes de um produto em um cartão (Card)
class ProductCard extends StatelessWidget {
  final Product product; // Produto a ser exibido

  // Construtor que recebe um produto e utiliza o id como chave única
  ProductCard({required this.product}) : super(key: ValueKey(product.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${product.price.toStringAsFixed(2)}'),
            SizedBox(height: 4),
            Text(
              'Subcategoria: ${product.subCategory.name}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Categoria: ${product.subCategory.category.name}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botão de editar (Atualizar)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddProductPopup(
                      product: product, // Passa o produto para edição
                    );
                  },
                );
              },
            ),
            // Botão de deletar
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Provider.of<ProductController>(context, listen: false)
                    .removeProduct(product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
