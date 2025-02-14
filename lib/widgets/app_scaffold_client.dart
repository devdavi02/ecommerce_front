// Importa as telas necessárias para navegação no aplicativo
import 'package:ecommerce_front/controllers/category_controller.dart';
import 'package:ecommerce_front/controllers/subcategory_controller.dart';
import 'package:ecommerce_front/models/category.dart';
import 'package:ecommerce_front/models/subcategory.dart';
import 'package:ecommerce_front/screens/cart_screen.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/screens/orders_screen.dart';
import 'package:ecommerce_front/screens/product_list_screen_client.dart';
import 'package:flutter/material.dart';

// Classe AppScaffold, que define a estrutura básica do aplicativo
class AppScaffoldClient extends StatelessWidget {
  // Define o conteúdo principal da tela que será exibido no corpo
  final Widget bodyContent;

  // Construtor da classe AppScaffold que recebe o conteúdo principal como parâmetro
  AppScaffoldClient({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Configuração da AppBar na parte superior da tela
      appBar: AppBar(
        title: Text("E-Commerce"), // Define o título do app bar
        actions: [
          // Exibe o avatar do usuário e um menu suspenso (PopupMenuButton) no app bar
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/user_avatar.webp"),
              ),
              SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  } else if (value == 'pedidos') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderListScreen()),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(value: 'pedidos', child: Text('Pedidos')),
                    PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
                  ];
                },
                child: Text("Nome do Usuário"),
              ),
            ],
          ),
        ],
      ),
      // Configuração do Drawer, que é um menu lateral
      drawer: Drawer(
        child: FutureBuilder<List<Category>>(
          future: CategoryController().fetchCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar categorias'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhuma categoria encontrada'));
            } else {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ...snapshot.data!.map((category) {
                    return ExpansionTile(
                      title: Text(category.name),
                      children: [
                        FutureBuilder<List<SubCategory>>(
                          future: SubCategoryController().fetchSubCategoriesByCategoryId(category.id),
                          builder: (context, subcategorySnapshot) {
                            if (subcategorySnapshot.connectionState == ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              );
                            } else if (subcategorySnapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Erro ao carregar subcategorias'),
                              );
                            } else if (!subcategorySnapshot.hasData || subcategorySnapshot.data!.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nenhuma subcategoria encontrada'),
                              );
                            } else {
                              return Column(
                                children: subcategorySnapshot.data!.map((subcategory) {
                                  return ListTile(
                                    title: Text(subcategory.name),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppScaffoldClient(
                                            bodyContent: ProductListScreenClient(
                                              subcategoryId: subcategory.id,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ],
              );
            }
          },
        ),
      ),
      // Define o conteúdo principal da tela
      body: bodyContent,
    );
  }
}
