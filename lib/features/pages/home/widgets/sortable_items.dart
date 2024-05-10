import 'package:aiapparel/features/pages/home/controllers/all_items_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/layouts/grid_layout.dart';
import '../../../../common/widgets/cards/vertical_card.dart';
import '../../../../utils/constants/sizes.dart';
import '../models/item_model.dart';
import 'package:get/get.dart';

class ASortableItems extends StatelessWidget {
  const ASortableItems({
    super.key,
    required this.items,
  });

  final List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllItemsController());
    controller.assignItems(items);
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortItems(value!);
          },
          items: ['Name', 'Newest', 'Popularity']
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),
        Obx(
          () => AGridLayout(
              itemCount: controller.items.length,
              itemBuilder: (_, index) =>
                  AVerticalCard(item: controller.items[index])),
        ),
      ],
    );
  }
}
