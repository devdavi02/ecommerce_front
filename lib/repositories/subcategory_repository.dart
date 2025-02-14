import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:http/http.dart' as http;
import '../models/subcategory.dart';

class SubCategoryRepository {
  final String baseUrl =
      "http://localhost:8000"; // Troque pela URL do seu backend

  Future<List<SubCategory>> fetchSubCategory() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/subcategory/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<SubCategory> subcategory =
          body.map((item) => SubCategory.fromJson(item)).toList();
      return subcategory;
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<List<SubCategory>> fetchSubCategoryByCategoryId(int id) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/subcategory/category/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<SubCategory> subcategory =
          body.map((item) => SubCategory.fromJson(item)).toList();
      return subcategory;
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = AppStorage.instance.token;
    if (token != null) {
      return {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    }
    return {"Content-Type": "application/json"};
  }

  Future<SubCategory> createSubCategory(SubCategory subcategory) async {
    final headers =
        await _getHeaders(); // Use o mesmo método para pegar os headers com token
    final response = await http.post(
      Uri.parse('$baseUrl/subcategory/save'),
      headers: headers, // Passando o cabeçalho com o token
      body: jsonEncode(subcategory.toJson()),
    );

    if (response.statusCode == 200) {
      return SubCategory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create subcategory');
    }
  }

  Future<void> deleteSubCategory(int id) async {
    final headers =
        await _getHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl/subcategory/$id'),
      headers: headers,
    );
    /// Throws an [Exception] if the request was not successful.

    if (response.statusCode != 200) {
      throw Exception('Failed to delete subcategory');
    }
  }
}
