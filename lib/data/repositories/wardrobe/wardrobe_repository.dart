import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/pages/home/models/wardrobe_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';

class WardrobeRepository extends GetxController {
  static WardrobeRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the current user or throws an exception if not authenticated.
  User _getAuthenticatedUser() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user;
  }

  Future<void> saveWardrobeRecord(WardrobeModel item) async {
    try {
      final user = _getAuthenticatedUser();
      final newItem = WardrobeModel(
        id: item.id, // Use existing item ID if provided.
        userId: user.uid,
        image: item.image,
        name: item.name,
        category: item.category,
        colour: item.colour,
        brand: item.brand,
        date: DateTime.now(), // Setting the current date and time
      );
      await _db
          .collection("Wardrobe_Items")
          .doc(item.id)
          .set(newItem.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WardrobeModel>> fetchAllWardrobeItemsForUser() async {
    try {
      final user = _getAuthenticatedUser();
      final querySnapshot = await _db
          .collection("Wardrobe_Items")
          .where('userId', isEqualTo: user.uid)
          .get();
      return querySnapshot.docs
          .map((doc) => WardrobeModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  // Fetch count of wardrobe items for the authenticated user
  Future<int> fetchWardrobeItemCountForUser() async {
    try {
      final user = _getAuthenticatedUser();
      final querySnapshot = await _db
          .collection("Wardrobe_Items")
          .where('userId', isEqualTo: user.uid)
          .get();
      return querySnapshot.size; // Return the number of documents
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  /// Updates details of an existing wardrobe item.
  Future<void> updateWardrobeDetails(WardrobeModel updatedItem) async {
    try {
      final user = _getAuthenticatedUser();
      await _db.collection("Wardrobe_Items").doc(updatedItem.id).update(updatedItem.toJson());
    } on FirebaseException catch (e) {
    throw AFirebaseException(e.code).message;
    } catch (e) {
    rethrow;
    }
  }

  /// Removes a wardrobe record from Firestore.
  Future<void> removeWardrobeRecord(String id) async {
    try {
      await _db.collection("Wardrobe_Items").doc(id).delete();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  /// Uploads an image to Firebase Storage and returns the download URL.
  Future<String> uploadImage(String path, XFile image) async {
    final ref = FirebaseStorage.instance.ref(path).child('${DateTime.now().millisecondsSinceEpoch}_${image.name}');
    await ref.putFile(File(image.path));
    return await ref.getDownloadURL();
  }

  /// Deletes an image from Firebase Storage.
  Future<void> deleteImage(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imagePath);
      await ref.delete();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } catch (e) {
    rethrow;
    }
  }

  /// Labels an image and returns a list of labels.
  Future<List<String>> labelImage(XFile file) async {
    final InputImage inputImage = InputImage.fromFilePath(file.path);
    final ImageLabelerOptions options = ImageLabelerOptions(confidenceThreshold: 0.7);
    final ImageLabeler labeler = ImageLabeler(options: options);

    final List<ImageLabel> labels = await labeler.processImage(inputImage);
    return labels.map((label) => label.label).toList();
  }
}
