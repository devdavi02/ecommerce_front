import 'package:ecommerce_front/models/user.dart';
import '../repositories/user_repository.dart';

class UserService {
  final UserRepository _repository =
      UserRepository(); // Instância do repositório de subcategorias

  // Função para obter todas as subcategorias de uma categoria específica
  Future<List<User>> getUsers() async {
    return await _repository.fetchUsers();
  }

  // Função para adicionar uma nova subcategoria
  Future<User> addUser(User user) async {
    return await _repository.createUser(user);
  }

  // Função para remover uma subcategoria
  Future<void> removeUser(int id) async {
    return await _repository.deleteUser(id);
  }
}
