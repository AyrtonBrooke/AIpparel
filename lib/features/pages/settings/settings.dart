import 'package:aiapparel/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:aiapparel/common/widgets/heading/section_heading.dart';
import 'package:aiapparel/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:aiapparel/features/pages/settings/profile.dart';
import 'package:aiapparel/features/pages/settings/upload/upload.dart';
import 'package:aiapparel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/sizes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            APrimaryHeaderContainer(
              child: Column(
                children: [
                  AAppBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: AColors.white))),
                  AUserProfileTile(
                      onPressed: () => Get.to(() => const Profile())),
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  const ASectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  const ASettingsMenuTile(
                      icon: Iconsax.language_square,
                      title: 'Languages',
                      subTitle: 'Spoken language of your choice'),
                  const ASettingsMenuTile(
                      icon: Iconsax.notification_1,
                      title: 'Notifications',
                      subTitle: 'Set notification messages'),
                  const ASettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage'),
                  const SizedBox(height: ASizes.spaceBtwSections),
                  const ASectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  ASettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Uploads',
                      subTitle: 'Upload Data',
                    onTap: () => Get.to(() => const UploadPage()), // Navigate to UploadPage
                  ),
                  SizedBox(
                    width: double.infinity,
                    child:
                        OutlinedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: const Text('Logout')),
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
