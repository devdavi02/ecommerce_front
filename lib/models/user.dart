import 'package:ecommerce_front/models/role.dart';

class User {
  int id;
  String userName;
  String password;
  int roleId; // ID da categoria à qual a subcategoria pertence
  Role role; // Objeto Role para acessar informações da categoria

  // Construtor da classe User
  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.roleId,
    required this.role,
  });

  // Fábrica que cria uma instância de User a partir de um JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['username'],
      password: json['password'],
      roleId: json['role_id'],
      role: Role.fromJson(json['role']),
    );
  }

  // Método que converte uma instância de User para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'password': password,
      'role_id': roleId,
    };
  }
}
