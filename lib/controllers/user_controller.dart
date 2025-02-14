import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController extends ChangeNotifier {
  final UserService _service = UserService();
  List<User> _user = [];

  List<User> get user => _user;

  // Função para carregar os produtos
  Future<void> loadUser() async {
    try {
      _user = await _service.getUsers();
      notifyListeners();
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addUser(User user) async {
    try {
      final addedUser = await _service.addUser(user);
      _user.add(addedUser);
      notifyListeners();
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeUser(int id) async {
    try {
      await _service.removeUser(id);
      _user.removeWhere((user) => user.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}