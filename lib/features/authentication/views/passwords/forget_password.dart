import 'package:aiapparel/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:aiapparel/utils/constants/text_strings.dart';
import 'package:aiapparel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ATexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(ATexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: ASizes.spaceBtwItems * 2),

            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: AValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText: ATexts.email, prefixIcon: Icon(Iconsax.direct_right)
                ),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text(ATexts.submit)))

          ],
        ),
      ),
    );
  }
}
