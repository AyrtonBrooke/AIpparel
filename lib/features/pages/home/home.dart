import 'package:aiapparel/common/layouts/grid_layout.dart';
import 'package:aiapparel/features/pages/home/controllers/item_controller.dart';
import 'package:aiapparel/features/pages/home/widgets/home_appbar.dart';
import 'package:aiapparel/features/pages/home/widgets/home_categories.dart';
import 'package:aiapparel/features/pages/home/widgets/promo_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cards/vertical_card.dart';
import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../common/widgets/heading/section_heading.dart';
import '../../../common/widgets/shimmer/vertical_items_shimmer.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import 'all_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const APrimaryHeaderContainer(
              child: Column(
                children: [
                  AHomeAppBar(),
                  SizedBox(height: ASizes.spaceBtwItems),
                  ASearchContainer(text: 'Search'),
                  SizedBox(height: ASizes.spaceBtwItems),
                  Padding(
                    padding: EdgeInsets.only(left: ASizes.defaultSpace),
                    child: Column(
                      children: [
                        ASectionHeading(
                          title: 'Popular Styles',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: ASizes.spaceBtwItems),
                        AHomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  const APromoSlider(),
                  const SizedBox(height: ASizes.spaceBtwSections),
                  ASectionHeading(
                      title: 'Popular Items',
                      onPressed: () => Get.to(() => AllItems(
                            title: 'Popular Products',
                      futureMethod: controller.fetchAllFeaturedItems(),
                      ))),
                  const SizedBox(height: ASizes.spaceBtwSections),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const AVerticalItemShimmer();
                    }
                    if (controller.featuredItems.isEmpty) {
                      return Center(
                          child: Text('No data found',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return AGridLayout(
                        itemCount: controller.featuredItems.length,
                        itemBuilder: (_, index) => AVerticalCard(
                            item: controller.featuredItems[index]));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
