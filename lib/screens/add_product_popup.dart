import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../controllers/subcategory_controller.dart';
import '../models/product.dart';
import '../models/subcategory.dart';

class AddProductPopup extends StatefulWidget {
  final Product? product; // Produto opcional para edição

  AddProductPopup({this.product});

  @override
  _AddProductPopupState createState() => _AddProductPopupState();
}

class _AddProductPopupState extends State<AddProductPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  SubCategory? _selectedSubCategory;

  @override
  void initState() {
    super.initState();
    final subCategoryController =
        Provider.of<SubCategoryController>(context, listen: false);

    if (widget.product != null) {
      _name = widget.product!.name;
      _price = widget.product!.price;

      // Busca a subcategoria correspondente na lista carregada
      _selectedSubCategory = subCategoryController.subcategory.firstWhere(
        (sub) => sub.id == widget.product!.subCategoryId,
        orElse: () => widget.product!.subCategory,
      );
    } else {
      _name = '';
      _price = 0.0;
      _selectedSubCategory = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final subCategories =
        Provider.of<SubCategoryController>(context).subcategory;

    return AlertDialog(
      title: Text(
          widget.product == null ? 'Adicionar Produto' : 'Atualizar Produto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Informe o nome do produto'
                  : null,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: InputDecoration(labelText: 'Preço do Produto'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || double.tryParse(value) == null
                      ? 'Informe um preço válido'
                      : null,
              onSaved: (value) => _price = double.parse(value!),
            ),
            DropdownButtonFormField<SubCategory>(
              decoration: InputDecoration(labelText: 'Subcategoria'),
              value: subCategories.contains(_selectedSubCategory)
                  ? _selectedSubCategory
                  : null,
              items: subCategories.map((subCategory) {
                return DropdownMenuItem<SubCategory>(
                  value: subCategory,
                  child: Text(subCategory.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSubCategory = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Selecione uma subcategoria' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(widget.product == null ? 'Adicionar' : 'Atualizar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newProduct = Product(
                id: widget.product?.id ?? 0, // Mantém o ID do produto original
                name: _name,
                price: _price,
                average: widget.product?.average ?? 0,
                subCategoryId: _selectedSubCategory!.id,
                subCategory: _selectedSubCategory!,
              );

              final productController =
                  Provider.of<ProductController>(context, listen: false);
              if (widget.product == null) {
                productController.addProduct(newProduct);
              } else {
                productController.updateProduct(newProduct.id, newProduct);
              }

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
