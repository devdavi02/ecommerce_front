import 'package:ecommerce_front/screens/add_subcategory_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subcategory.dart';
import '../controllers/subcategory_controller.dart';

// Widget que exibe os detalhes de uma subcategoria em um cartão (Card)
class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory; // Subcategoria a ser exibida

  // Construtor que recebe uma subcategoria e usa o id como chave única
  SubCategoryCard({required this.subCategory})
      : super(key: ValueKey(subCategory.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(subCategory.name), // Nome da subcategoria
        subtitle: Text(
          'Categoria: ${subCategory.category.name}', // Nome da categoria associada
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botão de editar
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue), // Ícone de edição
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSubCategoryPopup(subCategory: subCategory);
                  },
                );
              },
            ),
            // Botão de deletar
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Provider.of<SubCategoryController>(context, listen: false)
                    .removeSubCategory(subCategory.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
