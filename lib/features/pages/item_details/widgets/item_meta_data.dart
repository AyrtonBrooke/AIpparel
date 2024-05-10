import 'package:aiapparel/common/widgets/images/circular_images.dart';
import 'package:aiapparel/common/widgets/texts/title_text.dart';
import 'package:aiapparel/features/pages/home/controllers/item_controller.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/heading/section_heading.dart';
import '../../../../common/widgets/texts/brand_title_verified.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../home/models/item_model.dart';

class AItemMetaData extends StatelessWidget {
  const AItemMetaData({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final controller = ItemController.instance;
    final dark = AHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ATitleText(title: item.title),
            const SizedBox(width: ASizes.spaceBtwItems),
            ACircularImage(
              image: item.brand != null ? item.brand!.name : '',
              width: 32,
              height: 32,
              overlayColor: dark ? AColors.white : AColors.black,
            ),
            ABrandTitleVerified(
              title: item.brand != null ? item.brand!.name : '',
              brandTextSize: TextSizes.medium,
            )
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        const ASectionHeading(title: 'Description', showActionButton: false),
        const SizedBox(height: ASizes.spaceBtwItems),
          ReadMoreText(
          item.description ?? '',
          trimCollapsedText: 'Show more',
          trimLines: 2,
          trimExpandedText: 'Less',
          trimMode: TrimMode.Line,
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: ASizes.spaceBtwSections / 1.5),
      ],
    );
  }
}
