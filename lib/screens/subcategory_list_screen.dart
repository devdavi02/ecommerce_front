import 'package:ecommerce_front/models/subcategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/subcategory_controller.dart';
import '../widgets/subcategory_card.dart';
import 'add_subcategory_popup.dart';

class SubCategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<SubCategoryController>(context, listen: false);

    Provider.of<SubCategoryController>(context, listen: false)
        .loadSubCategory();

    return Stack(
      children: [
        Consumer<SubCategoryController>(
          builder: (context, controller, child) {
            if (controller.subcategory.isEmpty) {
              return const Center(child: Text("Nenhum produto cadastrado"));
            }
            return ListView.builder(
              itemCount: controller.subcategory.length,
              itemBuilder: (context, index) {
                return SubCategoryCard(subCategory: controller.subcategory[index]);
              },
            );
          },
        ),
        FutureBuilder(
          future: controller
              .loadSubCategory(), // Carregar as subcategorias uma única vez
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar subcategorias'));
            }

            if (controller.subcategory.isEmpty) {
              return const Center(
                  child: Text("Nenhuma subcategoria cadastrada"));
            }

            return ListView.builder(
              itemCount: controller.subcategory.length,
              itemBuilder: (context, index) {
                return SubCategoryCard(
                    subCategory: controller.subcategory[index]);
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
                  return AddSubCategoryPopup();
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
