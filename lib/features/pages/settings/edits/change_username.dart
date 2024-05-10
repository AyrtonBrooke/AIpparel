import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:aiapparel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/controllers/edits/update_fields_controller.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Change username', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: ASizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
                  child: TextFormField(
                    controller: controller.username,
                    validator: (value) => AValidator.validateEmptyText('username', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: ATexts.username, prefixIcon: Icon(Iconsax.user)),
                  ),
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
