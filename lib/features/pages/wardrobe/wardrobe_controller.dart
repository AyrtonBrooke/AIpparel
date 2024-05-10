import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/pages/home/models/wardrobe_model.dart';
import '../../../data/repositories/wardrobe/wardrobe_repository.dart';
import 'package:aiapparel/utils/helpers/image_utils.dart';

import '../../../utils/helpers/brand_text_extract.dart';

class WardrobeController extends GetxController {
  static WardrobeController get instance => Get.find();

  final wardrobeRepository = Get.put(WardrobeRepository());
  RxList<WardrobeModel> wardrobeItems = <WardrobeModel>[].obs;
  RxInt wardrobeItemCount = 0.obs; // Observable item count
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
    updateWardrobeItemCount();
  }

  void setLoading(bool value) => isLoading.value = value;

  // Display error message using GetX's snackbar
  void showError(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }

  // Fetch all wardrobe items for the current user
  Future<void> fetchAllItems() async {
    setLoading(true);
    try {
      final items = await wardrobeRepository.fetchAllWardrobeItemsForUser();
      wardrobeItems.assignAll(items);
    } catch (e) {
      showError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Update the wardrobe item count for the current user
  Future<void> updateWardrobeItemCount() async {
    setLoading(true);
    try {
      final count = await wardrobeRepository.fetchWardrobeItemCountForUser();
      wardrobeItemCount.value = count; // Update the observable count
    } catch (e) {
      showError('Unable to fetch item count: $e');
    } finally {
      setLoading(false);
    }
  }

  // Add a new wardrobe item to Firestore
  Future<void> addItem(WardrobeModel item) async {
    setLoading(true);
    try {
      item.date = DateTime.now();
      await wardrobeRepository.saveWardrobeRecord(item);
      wardrobeItems.add(item);
      updateWardrobeItemCount();
    } catch (e) {
      showError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Remove a wardrobe item from Firestore and delete its associated image
  Future<void> removeItem(String id, String imagePath) async {
    setLoading(true);
    try {
      await wardrobeRepository.removeWardrobeRecord(id); // Use the item ID directly
      await wardrobeRepository.deleteImage(imagePath);
      wardrobeItems.removeWhere((item) => item.id == id);
      updateWardrobeItemCount();
    } catch (e) {
      showError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Update an existing wardrobe item in Firestore
  Future<void> updateItem(String id, WardrobeModel updatedItem) async {
    setLoading(true);
    try {
      await wardrobeRepository.updateWardrobeDetails(updatedItem);
      final index = wardrobeItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        wardrobeItems[index] = updatedItem;
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Show a modal dialog to select an image source (camera or gallery)
  void showPickOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              pickImage(ImageSource.camera);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

// Define mappings for categories, colors, and brands
  Map<String, List<String>> categoryMapping = {
    'Shirt': ['shirt', 'blouse', 'top', 't-shirt'],
    'Pants': ['pants', 'trousers', 'jeans'],
    'Hat': ['hat', 'cap', 'beanie'],
    'Shoes': ['shoes', 'sneakers', 'sandals', 'boots'],
    'Hoodie': ['hoodie', 'sweatshirt'],
    'Shorts': ['shorts', 'bermuda', 'trunks'],
  };

  Map<String, List<String>> colorMapping = {
    'Red': ['red', 'scarlet', 'crimson', 'maroon', 'rose', 'burgundy'],
    'Blue': ['blue', 'navy', 'azure', 'teal', 'aqua', 'sky'],
    'Green': ['green', 'emerald', 'olive', 'lime', 'forest', 'sea'],
    'Black': ['black', 'ebony', 'charcoal', 'onyx'],
    'White': ['white', 'ivory', 'cream', 'snow', 'pearl'],
    'Yellow': ['yellow', 'amber', 'gold', 'mustard', 'lemon'],
    // Add other colors as needed
  };


  Map<String, List<String>> brandMapping = {
    'Nike': ['nike', 'swoosh', 'just do it'],
    'Adidas': ['adidas', 'three stripes', 'trefoil'],
    'Puma': ['puma', 'leaping cat'],
    'Gucci': ['gucci', 'double g', 'gg'],
    'Zara': ['zara'],
    'Under Armour': ['under armour', 'ua'],
    'Reebok': ['reebok', 'vector logo'],
    'New Balance': ['new balance', 'nb'],
    'H&M': ['h&m', 'hennes and mauritz'],
    'Levi\'s': ['levi\'s', 'levis', 'levi strauss'],
    'Uniqlo': ['uniqlo'],
    'Tommy Hilfiger': ['tommy hilfiger', 'hilfiger'],
    'Calvin Klein': ['calvin klein', 'ck'],
    'Lacoste': ['lacoste', 'crocodile'],
    'Fila': ['fila'],
  };


  // Determine category from the detected labels
  String determineCategory(List<String> detectedLabels) {
    return categoryMapping.keys.firstWhere(
          (category) => detectedLabels.any((label) => categoryMapping[category]!.contains(label.toLowerCase())),
      orElse: () => '',
    );
  }

  // Determine color from the detected labels
  String determineColor(List<String> detectedLabels) {
    return colorMapping.keys.firstWhere(
          (color) => detectedLabels.any((label) => colorMapping[color]!.contains(label.toLowerCase())),
      orElse: () => '',
    );
  }

  // Determine brand from the detected labels
  String determineBrand(List<String> detectedLabels) {
    return brandMapping.keys.firstWhere(
          (brand) => detectedLabels.any((label) => brandMapping[brand]!.contains(label.toLowerCase())),
      orElse: () => '',
    );
  }
  // Add a new wardrobe item with image labeling, text extraction, and dominant color detection
  Future<void> addNewItemWithImageLabeling(XFile image) async {
    setLoading(true);
    try {
      // Upload image and get URL
      final imageUrl = await wardrobeRepository.uploadImage('uploads/wardrobe_images', image);

      // Get labels from the image
      final labels = await wardrobeRepository.labelImage(image);

      // Determine the category, color, and brand based on detected labels
      final category = determineCategory(labels);

      // Detect the brand using text recognition
      final brand = await detectBrandFromText(image);

      // Determine the dominant color using the separate helper function
      final dominantColor = await getDominantColor(image);
      final color = dominantColor.isNotEmpty ? dominantColor : determineColor(labels);

      // Create a new WardrobeModel
      final newItem = WardrobeModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        name: 'New Item',
        image: imageUrl,
        category: category,
        colour: color,
        brand: brand,
      );

      // Save the new item record
      await wardrobeRepository.saveWardrobeRecord(newItem);

      // Update the controller's list with the new item
      wardrobeItems.add(newItem);

      updateWardrobeItemCount();
    } catch (e) {
      showError('Error adding item: $e');
    } finally {
      setLoading(false);
    }
  }

  // Pick an image from the selected source (camera or gallery) and add it with labeling
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      await addNewItemWithImageLabeling(pickedFile);
    }
  }
}
