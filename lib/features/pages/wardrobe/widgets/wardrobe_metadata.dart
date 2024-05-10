import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../features/pages/home/models/wardrobe_model.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../wardrobe_controller.dart';
import '../wardrobe_meta_controller.dart';

class AWardrobeMetaData extends StatelessWidget {
  const AWardrobeMetaData({super.key, required this.item});

  final WardrobeModel item;

  @override
  Widget build(BuildContext context) {
    final wardrobeController = Get.find<WardrobeController>();
    final controller = Get.put(WardrobeMetaDataController(item));
    final dark = AHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                onChanged: controller.updateItemName,
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: controller.updateDescription,
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.brandController,
                decoration: const InputDecoration(labelText: 'Brand'),
                onChanged: controller.updateBrand,
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: controller.updateCategory,
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.colourController,
                decoration: const InputDecoration(labelText: 'Colour'),
                onChanged: controller.updateColour,
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.sizeController,
                decoration: const InputDecoration(labelText: 'Size'),
                onChanged: controller.updateSize,
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwSections),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => controller.saveItem(item),
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text('Save', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 3.0,
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  visualDensity: VisualDensity.compact, // Adjust spacing
                ),
              ),
            ),
            const SizedBox(width: ASizes.spaceBtwSections),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  wardrobeController.removeItem(item.id, item.image);
                  Get.back(); // Navigate back to previous page
                },
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text('Delete', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 3.0,
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  visualDensity: VisualDensity.compact, // Adjust spacing
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
