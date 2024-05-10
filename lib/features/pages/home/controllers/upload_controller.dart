import 'package:get/get.dart';

import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../data/repositories/items/item_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../models/category_model.dart'; // Import Get for GetX

class UploadController extends GetxController {
  static UploadController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final _brandsRepository = Get.put(CategoryRepository());
  final _itemsRepository = Get.put(ItemRepository());
  final _bannersRepository = Get.put(CategoryRepository());

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  Future<void> uploadCategories() async {
    try {
      isLoading.value = true;
      await _categoryRepository.uploadData(allCategories);
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadItems() async {
    try {
      isLoading.value = true;
      await _categoryRepository.uploadData(allCategories);
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadBrands() async {
    try {
      isLoading.value = true;
      await _categoryRepository.uploadData(allCategories);
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadBanners() async {
    try {
      isLoading.value = true;
      await _categoryRepository.uploadData(allCategories);
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
