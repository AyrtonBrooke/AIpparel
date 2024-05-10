import 'package:aiapparel/data/repositories/categories/category_repository.dart';
import 'package:aiapparel/data/repositories/items/item_repository.dart';
import 'package:aiapparel/features/pages/home/models/category_model.dart';
import 'package:aiapparel/features/pages/home/models/item_model.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();

      allCategories.assignAll(categories);

      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured)
          .take(8)
          .toList());
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<ItemModel>> getCategoryItems(
      {required String categoryId, int limit = 4}) async {
    try {
      final items = await ItemRepository.instance
          .getItemsForCategory(categoryId: categoryId, limit: limit);
      return items;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
