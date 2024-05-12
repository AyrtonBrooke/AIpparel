import 'package:aiapparel/features/pages/wardrobe/wardrobe_image_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/layouts/grid_layout.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'wardrobe_controller.dart';

class WardrobePage extends StatelessWidget {
  const WardrobePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
    final controller = Get.put(WardrobeController());

    return Scaffold(
      appBar: AAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wardrobe',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Obx(() => Text(
              '${controller.wardrobeItemCount.value} items',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
          ],
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(ASizes.defaultSpace),
                child: AGridLayout(
                  itemCount: controller.wardrobeItems.length,
                  itemBuilder: (_, index) {
                    final item = controller.wardrobeItems[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => WardrobeDetail(item: item)),
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.image,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showPickOptionsDialog(context),
        backgroundColor: dark ? AColors.white : AColors.black,
        tooltip: 'Add a new photo',
        child: Icon(Icons.add_a_photo,
            color: dark
                ? AColors.black
                : AColors.white), // Adding tooltip for accessibility
      ),
    );
  }
}
