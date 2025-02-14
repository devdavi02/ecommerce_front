// Importa as telas necessárias para navegação no aplicativo
import 'package:ecommerce_front/screens/category_list_screen.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/screens/product_list_screen_adm.dart';
import 'package:ecommerce_front/screens/product_list_screen_client.dart';
import 'package:ecommerce_front/screens/role_list_screen.dart';
import 'package:ecommerce_front/screens/subcategory_list_screen.dart';
import 'package:ecommerce_front/screens/user_list_screen.dart';
import 'package:flutter/material.dart';

// Classe AppScaffold, que define a estrutura básica do aplicativo
class AppScaffoldAdm extends StatelessWidget {
  // Define o conteúdo principal da tela que será exibido no corpo
  final Widget bodyContent;

  // Construtor da classe AppScaffold que recebe o conteúdo principal como parâmetro
  AppScaffoldAdm({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura Scaffold, que é a base da tela
    return Scaffold(
      // Configuração da AppBar na parte superior da tela
      appBar: AppBar(
        title: Text("Product App"), // Define o título do app bar
        actions: [
          // Exibe o avatar do usuário e um menu suspenso (PopupMenuButton) no app bar
          Row(
            children: [
              // CircleAvatar para mostrar a imagem do usuário
              CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/user_avatar.webp"), // Imagem do usuário no avatar
              ),
              SizedBox(width: 8), // Espaçamento entre o avatar e o menu
              // PopupMenuButton que exibe um menu ao clicar
              PopupMenuButton<String>(
                // Função chamada quando uma opção é selecionada
                onSelected: (value) {
                  if (value == 'logout') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }
                },
                // Define os itens do menu suspenso
                itemBuilder: (BuildContext context) {
                  return [
                    // Item do menu para Logout
                    PopupMenuItem<String>(
                      value: 'logout', // Valor associado à opção
                      child: Text('Logout'), // Texto exibido para o item
                    ),
                  ];
                },
                // Texto exibido no botão do menu suspenso
                child: Text("Nome do Usuário"), // Nome do usuário na AppBar
              ),
            ],
          ),
        ],
      ),
      // Configuração do Drawer, que é um menu lateral
      drawer: Drawer(
        // Define a lista de itens que aparecerão no drawer
        child: ListView(
          padding: EdgeInsets.zero, // Remove o padding padrão
          children: [
            // Cabeçalho do drawer
            DrawerHeader(
              child: Text(
                'Menu', // Título do drawer
                style: TextStyle(
                    color: Colors.white, fontSize: 24), // Estilo do texto
              ),
              decoration: BoxDecoration(
                  color: Colors.blue), // Cor de fundo do cabeçalho do drawer
            ),
            // Item de lista para navegação até a tela de produtos
            ListTile(
              title: Text('Produtos'), // Título do item "Produtos"
              onTap: () {
                // Navega para a tela de lista de produtos ao selecionar o item
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: ProductListScreenAdm()),
                  ),
                );
              },
            ),
            // Item de lista para navegação até a tela de categorias
            ListTile(
              title: Text('Categorias'), // Título do item "Categorias"
              onTap: () {
                // Navega para a tela de lista de categorias ao selecionar o item
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: CategoryListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Subcategorias'), // Título do item "Categorias"
              onTap: () {
                // Navega para a tela de lista de categorias ao selecionar o item
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: SubCategoryListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Perfil'), // Título do item "Categorias"
              onTap: () {
                // Navega para a tela de lista de categorias ao selecionar o item
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: RoleListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Usuário'), // Título do item "Categorias"
              onTap: () {
                // Navega para a tela de lista de categorias ao selecionar o item
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffoldAdm(bodyContent: UserListScreen()),
                  ),
                );
              },
            ),
            // Outros itens do menu podem ser adicionados aqui
          ],
        ),
      ),
      // Define o conteúdo principal da tela
      body: bodyContent,
    );
  }
}
