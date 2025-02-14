import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  final String baseUrl =
      "http://localhost:8000"; // Troque pela URL do seu backend

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body);
      AppStorage().setToken(token);
      return true;
    } else {
      throw Exception('Erro ao realizar login');
    }
  }
}