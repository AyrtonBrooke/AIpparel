import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:aiapparel/features/pages/home/models/wardrobe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/wardrobe/wardrobe_repository.dart';

class WardrobeMetaDataController extends GetxController {
  static WardrobeMetaDataController get instance => Get.find();

  late TextEditingController itemNameController;
  late TextEditingController descriptionController;
  late TextEditingController brandController;
  late TextEditingController categoryController;
  late TextEditingController colourController;
  late TextEditingController sizeController;
  late FirebaseFirestore _firestore;

  late WardrobeModel _item;
  WardrobeModel get item => _item;

  WardrobeMetaDataController(WardrobeModel initialItem) {
    _item = initialItem;
    itemNameController = TextEditingController(text: initialItem.name);
    descriptionController = TextEditingController(text: initialItem.description);
    brandController = TextEditingController(text: initialItem.brand);
    categoryController = TextEditingController(text: initialItem.category);
    colourController = TextEditingController(text: initialItem.colour);
    sizeController = TextEditingController(text: initialItem.size);
    _firestore = FirebaseFirestore.instance;
  }

  void updateItemName(String newName) {
    _item.name = newName;
    _firestore.collection('wardrobe_items').doc(_item.id).update({'name': newName});
    update(); // Notifies GetX about the change
  }

  void updateDescription(String newDescription) {
    _item.description = newDescription;
    _firestore.collection('wardrobe_items').doc(_item.id).update({'description': newDescription});
    update(); // Notifies GetX about the change
  }

  void updateBrand(String newBrand) {
    _item.brand = newBrand;
    _firestore.collection('wardrobe_items').doc(_item.id).update({'brand': newBrand});
    update(); // Notifies GetX about the change
  }

  void updateCategory(String newCategory) {
    _item.category = newCategory;
    _firestore.collection('wardrobe_items').doc(_item.id).update({'category': newCategory});
    update(); // Notifies GetX about the change
  }

  void updateColour(String newColour) {
    _item.colour = newColour;
    _firestore.collection('wardrobe_items').doc(_item.id).update({'colour': newColour});
    update(); // Notifies GetX about the change
  }

  void updateSize(String newSize) {
    _item.size = newSize;
    _firestore.collection('wardrobe_items').doc(_item.id).update({'size': newSize});
    update(); // Notifies GetX about the change
  }

  Future<void> saveItem(WardrobeModel item) async {
    try {
      final updatedItem = WardrobeModel(
        id: item.id,
        userId: item.userId,
        image: item.image,
        name: itemNameController.text,
        description: descriptionController.text,
        brand: brandController.text,
        category: categoryController.text,
        colour: colourController.text,
        size: sizeController.text,
        // Add other fields as needed
      );
      await WardrobeRepository.instance.updateWardrobeDetails(updatedItem);
      Get.snackbar('Success', 'Item updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save item: ${e.toString()}');
      // Handle error, e.g., show error message
    }
  }

  @override
  void onClose() {
    itemNameController.dispose();
    descriptionController.dispose();
    brandController.dispose();
    categoryController.dispose();
    colourController.dispose();
    sizeController.dispose();
    super.onClose();
  }
}
