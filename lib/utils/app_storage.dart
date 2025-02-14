import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get_storage/get_storage.dart';

// Classe responsável por gerenciar o armazenamento local de dados no aplicativo
class AppStorage {
  // Construtor privado para implementar o padrão Singleton, garantindo uma única instância
  AppStorage._internal();

  // Instância única (Singleton) da classe
  static final AppStorage instance = AppStorage._internal();

  // Factory constructor que retorna a instância única
  factory AppStorage() {
    return instance;
  }

  // Instância do GetStorage para gerenciar o armazenamento local
  var storage = GetStorage();

  // ----------------- Gerenciamento do Token -----------------

  // Getter para recuperar o token armazenado localmente
  String? get token => storage.read('token');

  int getUserId() {
    JWT jwtDecode = JWT.decode(AppStorage().token!);
    return jwtDecode.payload["user_id"];
  }

  int getRoleId() {
    JWT jwtDecode = JWT.decode(AppStorage().token!);
    return jwtDecode.payload["role_id"];
  }

  // Setter para armazenar ou remover o token
  // Se o token for nulo, remove a chave 'token' do armazenamento
  // Caso contrário, escreve o valor do token no armazenamento
  void setToken(String? token) =>
      (token == null) ? storage.remove('token') : storage.write('token', token);

  // Método para remover o token do armazenamento
  void removeToken() {
    storage.remove('token');
  }
}
