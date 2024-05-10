import 'package:aiapparel/common/widgets/login_signup/form_divider.dart';
import 'package:aiapparel/features/authentication/views/login/widgets/login_form.dart';
import 'package:aiapparel/features/authentication/views/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:aiapparel/common/styles/spacing_styles.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding: ASpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                const ALoginHeader(),
                const ALoginForm(),
                AFormDivider(dividerText: ATexts.orSignInWith.capitalize!),
                const SizedBox(height: ASizes.spaceBtwSections),
                const ASocialButtons()
              ],
            ),
          ),
        )
    );
  }
}




