import 'package:aiapparel/common/widgets/shimmer/category_shimmer.dart';
import 'package:aiapparel/features/pages/home/controllers/category_controller.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../utils/constants/colors.dart';
import 'package:get/get.dart';

import '../../sub_categories/sub_categories.dart';

class AHomeCategories extends StatelessWidget {
  const AHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const ACategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text('No data Found!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: AColors.white)));
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return AVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () => Get.to(() => SubCategoriesPage(category: category)));
          },
        ),
      );
    });
  }
}
