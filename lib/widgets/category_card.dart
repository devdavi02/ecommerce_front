import 'package:flutter/material.dart';
import '../models/category.dart';
import 'package:provider/provider.dart';
import '../controllers/category_controller.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category}) : super(key: ValueKey(category.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(category.name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<CategoryController>(context, listen: false)
                .removeCategory(category.id);
          },
        ),
      ),
    );
  }
}