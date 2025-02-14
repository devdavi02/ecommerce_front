import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../controllers/role_controller.dart';
import '../models/user.dart';
import '../models/role.dart';

class AddUserPopup extends StatefulWidget {
  @override
  _AddSubUserPopupState createState() => _AddSubUserPopupState();
}

class _AddSubUserPopupState extends State<AddUserPopup> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  Role? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final roles = Provider.of<RoleController>(context).roles;

    return AlertDialog(
      title: Text('Adicionar usuário'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do usuário'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do usuário';
                }
                return null;
              },
              onSaved: (value) {
                _userName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha do usuário'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a nova senha';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            DropdownButtonFormField<Role>(
              decoration: InputDecoration(labelText: 'Cargo'),
              items: roles.map((role) {
                return DropdownMenuItem<Role>(
                  value: role,
                  child: Text(role.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione uma cargo';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Adicionar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newUser = User(
                id: 0,
                userName: _userName,
                password: _password,
                roleId: _selectedRole!.id,
                role: _selectedRole!,
              );
              Provider.of<UserController>(context, listen: false)
                  .addUser(newUser);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
