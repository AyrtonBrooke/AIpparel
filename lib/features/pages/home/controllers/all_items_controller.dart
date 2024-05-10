
import 'package:aiapparel/features/pages/home/models/item_model.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/items/item_repository.dart';

class AllItemsController extends GetxController {
  static AllItemsController get instance => Get.find();

  final repository = ItemRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ItemModel> items = <ItemModel>[].obs;

  Future<List<ItemModel>> fetchItemsByQuery(Query? query) async {
    try {
      if(query == null) return [];

      final items = await repository.fetchItemsByQuery(query);

      return items;

    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortItems (String sortOption){
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name' :
        items.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Newest' :
        items.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
        items.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignItems(List<ItemModel> items) {
    this.items.assignAll(items);
    sortItems('Name');
  }
}

