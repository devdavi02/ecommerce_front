import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart'; // Importa o controlador de subcategorias
import '../widgets/user_card.dart'; // Importa o widget UserCard
import 'add_user_popup.dart'; // Importa a tela de pop-up para adicionar novas subcategorias

class UserListScreen extends StatelessWidget {
  // final int categoryId; // ID da categoria para carregar as subcategorias

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<UserController>(
          builder: (context, controller, child) {
            if (controller.user.isEmpty) {
              return const Center(
                  child: Text("Nenhum usuário cadastrado"));
            }
            return ListView.builder(
              itemCount: controller.user.length,
              itemBuilder: (context, index) {
                return UserCard(
                    user: controller.user[index]); // Exibe cada usuario usando UserCard
              },
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddUserPopup(); // Widget responsável por adicionar novas subcategorias
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor:
                Colors.orange, // Define a cor de fundo do botão como laranja
          ),
        ),
      ],
    );
  }
}