import 'package:aiapparel/common/styles/shadow.dart';
import 'package:aiapparel/common/widgets/images/rounded_images.dart';
import 'package:aiapparel/features/pages/home/models/item_model.dart';
import 'package:aiapparel/features/pages/item_details/item_detail.dart';
import 'package:aiapparel/utils/constants/colors.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/pages/item_details/widgets/favourite_icon.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../texts/brand_title_verified.dart';
import '../texts/title_text.dart';

class AVerticalCard extends StatelessWidget {
  const AVerticalCard({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ItemDetail(item: item)),
      child: Container(
        width: 180,
        height: 120,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AShadowStyle.verticalShadow],
          borderRadius: BorderRadius.circular(ASizes.itemImageRadius),
          color: dark ? AColors.darkerGrey : AColors.white,
        ),
        child: Column(
          children: [
            ARoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(ASizes.sm),
              backgroundColor: dark ? AColors.dark : AColors.light,
              child: Stack(
                children: [
                  Center(
                    child: ARoundedImage(
                        imageUrl: item.thumbnail, applyImageRadius: true, isNetworkImage: true),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: AFavouriteIcon(itemId: item.id)),
                ],
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwItems / 2),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: ASizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ATitleText(
                      title: item.title,
                      smallSize: true,
                    ),
                    const SizedBox(height: ASizes.spaceBtwItems / 2),
                    ABrandTitleVerified(title: item.brand!.name),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
