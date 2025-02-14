import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Para gerenciar o estado com o controller
import '../controllers/category_controller.dart';
import '../widgets/category_card.dart';
import 'add_category_popup.dart'; // A tela de adicionar categoria

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Carregar as categorias quando a tela for construída
    final controller = Provider.of<CategoryController>(context, listen: false);
    controller.loadCategories();

    return Stack(
      children: [
        Consumer<CategoryController>(
          builder: (context, controller, child) {
            // Exibe uma mensagem centralizada se a lista de produtos estiver vazia
            if (controller.categories.isEmpty) {
              return const Center(child: Text("Nenhuma categoria cadastrado"));
            }
            // Caso contrário, exibe uma ListView dos produtos
            return ListView.builder(
              itemCount: controller.categories.length, // Número de produtos na lista
              itemBuilder: (context, index) {
                return CategoryCard(category: controller.categories[index]); // Exibe cada produto usando ProductCard
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
              // Exibe o pop-up de adicionar produto ao pressionar o botão
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddCategoryPopup(); // Widget responsável por adicionar novos produtos
                },
              );
            },
            child: Icon(Icons.add), // Ícone '+' para adicionar produtos
            backgroundColor: Colors.green, // Define a cor de fundo do botão como verde
          ),
        ),
      ],
    );
  }
}