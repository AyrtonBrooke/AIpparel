import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ALoginHeader extends StatelessWidget {
  const ALoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 150,
              image: AssetImage(dark ? AImages.darkAppLogo : AImages.lightAppLogo),
            ),
            Text(ATexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.sm),
          ],
    );
  }
}
