import 'package:aiapparel/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:aiapparel/features/authentication/views/onboarding/widget/onboarding_navigation.dart';
import 'package:aiapparel/features/authentication/views/onboarding/widget/onboarding_next.dart';
import 'package:aiapparel/features/authentication/views/onboarding/widget/onboarding_page.dart';
import 'package:aiapparel/features/authentication/views/onboarding/widget/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:aiapparel/utils/constants/image_strings.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/text_strings.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:  const [
              onBoardingPage(image: AImages.onBoardingImage1,
                title: ATexts.onBoardingTitle1,
                subTitle: ATexts.onBoardingSubTitle1,
              ),
              onBoardingPage(image: AImages.onBoardingImage2,
                title: ATexts.onBoardingTitle2,
                subTitle: ATexts.onBoardingSubTitle2,
              ),
              onBoardingPage(image: AImages.onBoardingImage3,
                title: ATexts.onBoardingTitle3,
                subTitle: ATexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const onBoardingSkip(),

          const onBoardingNavigation(),

          const onBoardingNextButton(),
        ],
      ),
    );
  }
}




