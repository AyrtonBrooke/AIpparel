import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:aiapparel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/controllers/edits/update_fields_controller.dart';

class ChangeDOB extends StatelessWidget {
  const ChangeDOB({super.key});

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
              child: TextFormField(
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
