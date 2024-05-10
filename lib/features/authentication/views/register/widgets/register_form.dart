import 'package:aiapparel/features/authentication/views/register/widgets/terms_and_conditions_checkbox.dart';
import 'package:aiapparel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/register/register_controller.dart';

class ARegisterForm extends StatelessWidget {
  const ARegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      AValidator.validateEmptyText('First name', value),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: ATexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: ASizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      AValidator.validateEmptyText('Last name', value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: ATexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          ///username
          TextFormField(
            validator: (value) =>
                AValidator.validateEmptyText('Username', value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
                labelText: ATexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// email
          TextFormField(
            validator: (value) => AValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
                labelText: ATexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => AValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
                labelText: ATexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),
          Obx(() => DropdownButtonFormField<String>(
            validator: (value) =>
            value == null ? 'Please select your gender' : null,
            value: controller.gender.value,
            onChanged: (String? value) {
              controller.gender.value = value!;
            },
            items: controller.genderOptions
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: ATexts.gender,
              prefixIcon: Icon(Iconsax.direct),
            ),
          )),
          const SizedBox(height: ASizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => AValidator.validateEmptyText('Date of Birth', value),
            controller: controller.dob,
            decoration: const InputDecoration(
                labelText: ATexts.dob, prefixIcon: Icon(Iconsax.direct)),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                String formattedDate = '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}'; // Format the date as needed
                controller.dob.text = formattedDate;
              }
            },
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          ///password
          Obx(
            () => TextFormField(
              validator: (value) => AValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              controller: controller.password,
              decoration: InputDecoration(
                labelText: ATexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: ASizes.spaceBtwSections),

          const ATermsAndConditionsCheckbox(),
          const SizedBox(height: ASizes.spaceBtwSections),

          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.register(),
                  child: const Text(ATexts.createAccount))),
        ],
      ),
    );
  }
}
