import 'package:flutter/material.dart';
import '../models/role.dart';
import 'package:provider/provider.dart';
import '../controllers/role_controller.dart';

class RoleCard extends StatelessWidget {
  final Role role;

  RoleCard({required this.role}) : super(key: ValueKey(role.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(role.name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<RoleController>(context, listen: false)
                .removeRole(role.id);
          },
        ),
      ),
    );
  }
}