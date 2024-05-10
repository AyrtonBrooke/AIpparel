import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ASearchContainer extends StatelessWidget {
  const ASearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
        child: Container(
          width: ADeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(ASizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? AColors.dark
                    : AColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(ASizes.cardRadiusLg),
            border: showBorder ? Border.all(color: AColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: AColors.grey),
              const SizedBox(width: ASizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
    );
  }
}
