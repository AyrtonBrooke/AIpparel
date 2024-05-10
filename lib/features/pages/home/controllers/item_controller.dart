import 'package:aiapparel/features/pages/home/models/item_model.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/items/item_repository.dart';

class ItemController extends GetxController {
  static ItemController get instance => Get.find();

  final isLoading = false.obs;
  final itemRepository = Get.put(ItemRepository());
  RxList<ItemModel> featuredItems = <ItemModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedItems();
    super.onInit();
  }

  void fetchFeaturedItems() async {
    try {
      isLoading.value = true;

      final items = await itemRepository.getFeaturedItems();

      featuredItems.assignAll(items);

    }catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;

    }
  }

  Future<List<ItemModel>> fetchAllFeaturedItems() async {
    try {
      final items = await itemRepository.getFeaturedItems();
      return items;
    }catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}