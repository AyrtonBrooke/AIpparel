import 'package:aiapparel/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:aiapparel/features/authentication/views/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              children: [
                Lottie.asset(AImages.verifyEmail,
                    width: AHelperFunctions.screenWidth() * 0.6),
                const SizedBox(height: ASizes.spaceBtwSections),
                Text(email,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: ASizes.spaceBtwItems),
                Text(ATexts.changeYourPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: ASizes.spaceBtwItems),
                Text(ATexts.changeYourPasswordSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: ASizes.spaceBtwItems),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Get.offAll(() => const Login()),
                        child: const Text(ATexts.done))),
                SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () => ForgetPasswordController.instance
                            .resendPasswordResetEmail(email),
                        child: const Text(ATexts.resendEmail))),
              ],
            )),
      ),
    );
  }
}
