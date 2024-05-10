
import 'dart:convert';

import 'package:aiapparel/data/repositories/items/item_repository.dart';
import 'package:aiapparel/features/pages/home/models/item_model.dart';
import 'package:aiapparel/utils/local_storage/storage_utility.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() {
    final json = ALocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String itemId) {
    return favourites[itemId] ?? false;
  }

  void toggleFavouriteItem(String itemId) {
    if (!favourites.containsKey(itemId)){
      favourites[itemId] = true;
      saveFavouritesToStorage();
      ALoaders.customToast(message: 'Item has been added to your favourites');
    } else {
      ALocalStorage.instance().removeData(itemId);
      favourites.remove(itemId);
      saveFavouritesToStorage();
      favourites.refresh();
      ALoaders.customToast(message: 'Item has been removed from your favourites');
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    ALocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ItemModel>> favouriteItems() async {
    return await ItemRepository.instance.getFavouriteItems(favourites.keys.toList());
  }
}