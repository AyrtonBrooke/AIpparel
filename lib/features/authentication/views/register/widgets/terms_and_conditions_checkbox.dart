import 'package:aiapparel/features/authentication/controllers/register/register_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class ATermsAndConditionsCheckbox extends StatelessWidget {
  const ATermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RegisterController.instance;
    final dark = AHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
        const SizedBox(width: ASizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '${ATexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${ATexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? AColors.white : AColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? AColors.white : AColors.primary,
                    )),
            TextSpan(
                text: '${ATexts.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${ATexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? AColors.white : AColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? AColors.white : AColors.primary,
                    )),
          ]),
        ),
      ],
    );
  }
}
