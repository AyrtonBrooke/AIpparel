import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/common/widgets/cards/horizontal_card.dart';
import 'package:aiapparel/common/widgets/heading/section_heading.dart';
import 'package:aiapparel/common/widgets/images/rounded_images.dart';
import 'package:aiapparel/features/pages/home/controllers/category_controller.dart';
import 'package:aiapparel/features/pages/home/models/category_model.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:aiapparel/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/shimmer/horizontal_shimmer.dart';
import '../../../utils/constants/image_strings.dart';
import '../home/all_items.dart';

class SubCategoriesPage extends StatelessWidget {
  const SubCategoriesPage({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: AAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              const ARoundedImage(
                width: double.infinity,
                imageUrl: AImages.promoBanner3,
                applyImageRadius: true,
              ),
              const SizedBox(height: ASizes.spaceBtwSections),
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  const loader = AHorizontalItemShimmer();
                  final widget = ACloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryItems(
                            categoryId: subCategory.id),
                        builder: (context, snapshot) {
                          final widget =
                              ACloudHelperFunctions.checkMultiRecordState(
                                  snapshot: snapshot, loader: loader);
                          if (widget != null) return widget;

                          final items = snapshot.data!;
                          return Column(
                            children: [
                              ASectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                  () => AllItems(
                                      title: subCategory.name,
                                      futureMethod: controller.getCategoryItems(
                                          categoryId: subCategory.id,
                                          limit: -1)),
                                ),
                              ),
                              const SizedBox(height: ASizes.spaceBtwItems / 2),
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: items.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          width: ASizes.spaceBtwItems),
                                  itemBuilder: (context, index) =>
                                      AHorizontalCard(item: items[index]),
                                ),
                              ),
                              const SizedBox(height: ASizes.spaceBtwSections),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
