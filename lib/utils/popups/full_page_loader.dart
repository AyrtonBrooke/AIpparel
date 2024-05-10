import 'package:aiapparel/utils/constants/colors.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';

class AFullPageLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AHelperFunctions.isDarkMode(Get.context!)
              ? AColors.dark
              : AColors.white,
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              const SizedBox(height: 250),
              AAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
