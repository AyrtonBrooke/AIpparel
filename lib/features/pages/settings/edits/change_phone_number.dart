import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:aiapparel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/controllers/edits/update_fields_controller.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Change Phone Number', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: ASizes.spaceBtwSections),
            Form(
              key: controller.updateUserNameFormKey,
              child: TextFormField(
                validator: (value) => AValidator.validatePhoneNumber(value),
                controller: controller.phoneNumber,
                decoration: const InputDecoration(
                    labelText: ATexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
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
