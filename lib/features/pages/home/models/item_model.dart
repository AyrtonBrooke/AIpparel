import 'package:cloud_firestore/cloud_firestore.dart';
import 'brand_model.dart';

class ItemModel {
  String id;
  String title;
  BrandModel? brand;
  String? description;
  String? categoryId;
  bool? isFeatured;
  String thumbnail;
  DateTime? date;

  ItemModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.brand,
    this.date,
    this.description,
    this.categoryId,
    this.isFeatured,
  });

  static ItemModel empty() =>
      ItemModel(id: '', title: '', thumbnail: '');

  toJson() {
    return {
      'Id': id,
      'Title': title,
      'Thumbnail': thumbnail,
      'Brand': brand!.toJson(),
      'CategoryId': categoryId,
      'isFeatured': isFeatured,
      'Description': description,
    };
  }

  factory ItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null) return ItemModel.empty();
    final data = document.data()!;
    return ItemModel(
      id: document.id,
      title: data['Title'],
      isFeatured: data['isFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
    );
  }

  factory ItemModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if(document.data() == null) return ItemModel.empty();
    final data = document.data() as Map<String, dynamic>;
    return ItemModel(
      id: document.id,
      title: data['Title'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
    );
  }
}
