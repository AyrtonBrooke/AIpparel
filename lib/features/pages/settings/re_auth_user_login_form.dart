import 'package:aiapparel/features/authentication/controllers/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AAppBar(
        title: Text('Re-Authenticate', style: Theme
            .of(context)
            .textTheme
            .headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: AValidator.validateEmail,
                  decoration: const InputDecoration(labelText: ATexts.email,
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
                const SizedBox(height: ASizes.spaceBtwInputFields),
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) => AValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                    labelText: ATexts.password,
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                            icon: const Icon(Iconsax.eye_slash))),
                  ),
                ),
                const SizedBox(height: ASizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.reAuthenticateEmailAndPasswordUser(),
                    child: const Text('Verify'),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
