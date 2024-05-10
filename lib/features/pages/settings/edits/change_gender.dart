import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/controllers/edits/update_fields_controller.dart';

class ChangeGender extends StatelessWidget {
  const ChangeGender({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Change Date of Birth', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: ASizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
              child: Obx(() => DropdownButtonFormField<String>(
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
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateFields(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
