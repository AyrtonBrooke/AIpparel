import 'package:aiapparel/common/widgets/login_signup/form_divider.dart';
import 'package:aiapparel/features/authentication/views/register/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///title
                Text(ATexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: ASizes.spaceBtwSections),
                ///form
                const ARegisterForm(),
                const SizedBox(height: ASizes.spaceBtwSections),
                ///divider
                AFormDivider(dividerText: ATexts.orSignUpWith.capitalize!),
                const SizedBox(height: ASizes.spaceBtwSections),

                ///social buttons
                const ASocialButtons(),
              ],
          ),
        )
    ),
    );
  }
}





