
import 'package:cloud_firestore/cloud_firestore.dart';

class WardrobeModel {
  String id;
  String name, image;
  final String userId; // Add user ID field
  String? category, size, description, colour, brand;
  DateTime? date;

  WardrobeModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    this.brand,
    this.date,
    this.colour,
    this.size,
    this.description,
    this.category,
  });

  static WardrobeModel empty() =>
      WardrobeModel(id: '', name: '', image: '', userId: '');

  toJson() {
    return {
      'Id': id,
      'userId': userId,
      'Name': name,
      'Image': image,
      'Brand': brand,
      'Category': category,
      'Description': description,
      'Size': size,
      'Date': date?.toIso8601String(),
      'Colour': colour,
    };
  }

  factory WardrobeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null) return WardrobeModel.empty();
    final data = document.data()!;
    return WardrobeModel(
      id: document.id,
      userId: document['userId'],
      name: data['Name'],
      image: data['Image'],
      category: data['Category'] ?? '',
      brand: data['Brand'] ?? '',
      description: data['Description'] ?? '',
      size: data['Size'] ?? '',
      date: data['date'] != null ? DateTime.fromMillisecondsSinceEpoch(data['date']) : null,
      colour: data['Colours'] ?? '',
    );
  }

  factory WardrobeModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if(document.data() == null) return WardrobeModel.empty();
    final data = document.data() as Map<String, dynamic>;
    return WardrobeModel(
      id: document.id,
      userId: document['userId'],
      name: data['Name'],
      image: data['Image'],
      category: data['Category'] ?? '',
      brand: data['Brand'] ?? '',
      description: data['Description'] ?? '',
      size: data['Size'] ?? '',
      date: data['date'] != null ? DateTime.fromMillisecondsSinceEpoch(data['date']) : null,
      colour: data['Colours'] ?? '',
    );
  }
}
