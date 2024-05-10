import 'package:aiapparel/data/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/pages/home/models/item_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ItemRepository extends GetxController {
  static ItemRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ItemModel>> getFeaturedItems() async {
    try {
      final snapshot = await _db
          .collection('Items')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((document) => ItemModel.fromSnapshot(document)).toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ItemModel>> getAllFeaturedItems() async {
    try {
      final snapshot = await _db
          .collection('Items')
          .where('isFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((document) => ItemModel.fromSnapshot(document)).toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ItemModel>> getItemsForCategory({required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot itemCategoryQuery = limit == -1
          ? await _db.collection('ItemCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ItemCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      List<String> itemIds = itemCategoryQuery.docs.map((doc) => doc['itemId'] as String).toList();
      final itemsQuery = await _db.collection('Items').where(FieldPath.documentId, whereIn: itemIds).get();

      List<ItemModel> items = itemsQuery.docs.map((docs) => ItemModel.fromSnapshot(docs)).toList();
      return items;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ItemModel>> fetchItemsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ItemModel> itemList = querySnapshot.docs.map((doc) => ItemModel.fromQuerySnapshot(doc)).toList();
      return itemList;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ItemModel>> getFavouriteItems(List<String> itemIds) async {
    try {
      final snapshot = await _db.collection('Items').where(FieldPath.documentId, whereIn: itemIds).get();
      return snapshot.docs.map((querySnapshot) => ItemModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadData(List<ItemModel> items) async {
    try {
      final storage = Get.put(AFirebaseStorageService());

      for (var item in items) {
        final thumbnail = await storage.getImageDataFromAssets(item.thumbnail);

        final url = await storage.uploadImageData(
            'Items/Images', thumbnail, item.thumbnail.toString());

        item.thumbnail = url;

        await _db.collection("Items").doc(item.id).set(item.toJson());
      }
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
