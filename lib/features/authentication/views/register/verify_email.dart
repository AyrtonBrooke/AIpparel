import 'package:aiapparel/data/repositories/authentication/authentication_repository.dart';
import 'package:aiapparel/features/authentication/controllers/register/verify_email_controller.dart';
import 'package:aiapparel/utils/constants/image_strings.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          ),
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

              Text(ATexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: ASizes.spaceBtwItems),
              Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: ASizes.spaceBtwItems),
              Text(ATexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: ASizes.spaceBtwItems),

              SizedBox(width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerificationStatus(),
                      child: const Text(ATexts.tContinue)),
              ),
              const SizedBox(height: ASizes.spaceBtwItems),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text(ATexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
