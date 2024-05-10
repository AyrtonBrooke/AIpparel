import 'package:aiapparel/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = AHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: ADeviceUtils.getBottomNavigationBarHeight() + 25,
      left: ASizes.defaultSpace,
      child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(activeDotColor: dark ? AColors.light: AColors.dark, dotHeight: 6)
      ),
    );
  }
}
