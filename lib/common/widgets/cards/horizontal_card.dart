import 'package:flutter/material.dart';

import '../../../features/pages/home/models/item_model.dart';
import '../../../features/pages/item_details/item_detail.dart';
import '../../../features/pages/item_details/widgets/favourite_icon.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/rounded_images.dart';
import '../texts/brand_title_verified.dart';
import '../texts/title_text.dart';
import 'package:get/get.dart';

class AHorizontalCard extends StatelessWidget {
  const AHorizontalCard({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ItemDetail(item: item)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ASizes.itemImageRadius),
          color: dark ? AColors.darkerGrey : AColors.softGrey,
        ),
        child: Row(
          children: [
            ARoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(ASizes.sm),
              backgroundColor: dark ? AColors.dark : AColors.light,
              child: Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ARoundedImage(
                      imageUrl: item.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  Positioned(
                      top: 0, right: 0, child: AFavouriteIcon(itemId: item.id)),
                ],
              ),
            ),
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: ASizes.sm, left: ASizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ATitleText(title: item.title, smallSize: true),
                        const SizedBox(height: ASizes.spaceBtwItems / 2),
                        ABrandTitleVerified(title: item.brand!.name),
                      ],
                    ),
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
