// screens/product_list_screen.dart
import 'package:ecommerce_front/controllers/subcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart'; 
import '../widgets/product_card.dart'; 
import 'add_product_popup.dart'; 

class ProductListScreenAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context, listen: false);
    controller
        .loadProducts(); // Carrega a lista de produtos ao construir a tela

    Provider.of<SubCategoryController>(context, listen: false)
        .loadSubCategory();

    return Stack(
      children: [
        Consumer<ProductController>(
          builder: (context, controller, child) {
            // Exibe uma mensagem centralizada se a lista de produtos estiver vazia
            if (controller.products.isEmpty) {
              return const Center(child: Text("Nenhum produto cadastrado"));
            }
            // Caso contrário, exibe uma ListView dos produtos
            return ListView.builder(
              itemCount:
                  controller.products.length, // Número de produtos na lista
              itemBuilder: (context, index) {
                return ProductCard(
                    product: controller.products[
                        index]); // Exibe cada produto usando ProductCard
              },
            );
          },
        ),
        // Botão flutuante adicionado ao Stack
        Positioned(
          bottom: 16, // Distância da parte inferior da tela
          right: 16, // Distância do lado direito da tela
          child: FloatingActionButton(
            onPressed: () {
              // carrega as subcategorias antes de mostrar a tela de atualização ou adicionar

              
              // Exibe o pop-up de adicionar produto ao pressionar o botão
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddProductPopup(); // Widget responsável por adicionar novos produtos
                },
              );
            },
            child: Icon(Icons.add), // Ícone '+' para adicionar produtos
            backgroundColor:
                Colors.green, // Define a cor de fundo do botão como verde
          ),
        ),
      ],
    );
  }
}
