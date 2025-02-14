import 'package:flutter/material.dart';
import 'package:ecommerce_front/models/role.dart';
import 'package:ecommerce_front/services/role_service.dart';

class RoleController extends ChangeNotifier {
  final RoleService _service = RoleService();
  List<Role> _roles = [];

  List<Role> get roles => _roles;

  // Função para carregar os produtos
  Future<void> loadRoles() async {
    try {
      _roles = await _service.getRoles();
      notifyListeners();
    } catch (e) {
      print('Error loading roles: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addRole(Role role) async {
    try {
      final addedRole = await _service.addRole(role);
      _roles.add(addedRole);
      notifyListeners();
    } catch (e) {
      print('Error adding role: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeRole(int id) async {
    try {
      await _service.removeRole(id);
      _roles.removeWhere((role) => role.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting role: $e');
    }
  }
}