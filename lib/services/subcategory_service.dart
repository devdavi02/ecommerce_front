import '../models/subcategory.dart';
import '../repositories/subcategory_repository.dart';

class SubCategoryService {
  final SubCategoryRepository _repository = SubCategoryRepository();

  Future<List<SubCategory>> getSubCategory() {
    return _repository.fetchSubCategory();
  }

  Future<List<SubCategory>> getSubcategoryByCategoryId(int id) {
    return _repository.fetchSubCategoryByCategoryId(id);
  }

  Future<SubCategory> addSubCategory(SubCategory subcategory) {
    return _repository.createSubCategory(subcategory);
  }

  Future<void> removeSubCategory(int id) {
    return _repository.deleteSubCategory(id);
  }
}
