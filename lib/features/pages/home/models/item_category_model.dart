import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCategoryModel {
  final String itemId;
  final String categoryId;

  ItemCategoryModel({
    required this.itemId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'categoryId': categoryId,
    };
  }

  factory ItemCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ItemCategoryModel(
      itemId: data['itemId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
