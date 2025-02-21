import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final ProductRepository _repository = ProductRepository();

  Future<List<Product>> getProducts() async {
    return await _repository.fetchProducts();
  }

  Future<List<Product>> getProductsBySubcategory(int? subcategory) async {
    return await _repository.fetchProductsBySubcategory(subcategory);
  }

  Future<Product> addProduct(Product product) async {
    return await _repository.createProduct(product);
  }

  Future<void> removeProduct(int id) async {
    await _repository.deleteProduct(id);
  }

  Future<Product> updateProduct(int id, Product product) async {
    return await _repository.updateProduct(id, product);
  }

  Future<void> sendRating(int id, int grade) async {
    await _repository.sendRating(id, grade);
  }

  Future<List<Map<String, dynamic>>> loadQuestions(int id) async {
    return await _repository.fetchProductQuestions(id);
  }

  Future<void> sendQuestion(int id, String description) async {
    await _repository.sendQuestion(id, description);
  }
}
