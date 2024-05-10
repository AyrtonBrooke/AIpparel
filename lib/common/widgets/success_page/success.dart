import 'package:aiapparel/common/styles/spacing_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class Success extends StatelessWidget {
  const Success({super.key, required this.image, required this.title, required this.subTitle, this.onPressed});

  final String image, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: ASpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(
          children: [
            Lottie.asset(image,
                width: AHelperFunctions.screenWidth() * 0.6),
            const SizedBox(height: ASizes.spaceBtwSections),

            Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text('data', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
            const SizedBox(height: ASizes.spaceBtwItems),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: const Text(ATexts.tContinue))),

          ]

        ),
      ),
    );
  }
}