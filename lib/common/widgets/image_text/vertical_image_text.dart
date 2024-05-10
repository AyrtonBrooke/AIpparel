import 'package:aiapparel/common/widgets/images/circular_images.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class AVerticalImageText extends StatelessWidget {
  const AVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AColors.white,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ASizes.spaceBtwItems),
        child: Column(
          children: [
            ACircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: ASizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark
                  ? AColors.light
                  : AColors.dark,
            ),
            const SizedBox(height: ASizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Center(
                child: Text(
                  title,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
