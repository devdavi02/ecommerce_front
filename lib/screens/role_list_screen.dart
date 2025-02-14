import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Para gerenciar o estado com o controller
import '../controllers/role_controller.dart';
import '../widgets/role_card.dart';
import 'add_role_popup.dart'; // A tela de adicionar cargo

class RoleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Carregar as categorias quando a tela for construída
    final controller = Provider.of<RoleController>(context, listen: false);
    controller.loadRoles();

    return Stack(
      children: [
        Consumer<RoleController>(
          builder: (context, controller, child) {
            // Exibe uma mensagem centralizada se a lista de produtos estiver vazia
            if (controller.roles.isEmpty) {
              return const Center(child: Text("Nenhuma cargo cadastrado"));
            }
            // Caso contrário, exibe uma ListView dos produtos
            return ListView.builder(
              itemCount: controller.roles.length, // Número de produtos na lista
              itemBuilder: (context, index) {
                return RoleCard(role: controller.roles[index]); // Exibe cada produto usando ProductCard
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
                  return AddRolePopup(); // Widget responsável por adicionar novos produtos
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