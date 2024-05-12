import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';


class onBoardingPage extends StatelessWidget {
  const onBoardingPage({
    super.key, required this.animationAsset, required this.title, required this.subTitle,
  });

  final String animationAsset, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        children: [
          Lottie.asset(
            animationAsset,
            width: AHelperFunctions.screenWidth() * 0.8,
            height: AHelperFunctions.screenHeight() * 0.6,
            fit: BoxFit.fill,  // Optional, depending on your design needs
          ),
          Text(title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
