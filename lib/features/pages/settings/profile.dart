import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/common/widgets/heading/section_heading.dart';
import 'package:aiapparel/common/widgets/images/circular_images.dart';
import 'package:aiapparel/common/widgets/shimmer/shimmer.dart';
import 'package:aiapparel/features/pages/settings/edits/change_gender.dart';
import 'package:aiapparel/features/pages/settings/edits/change_name.dart';
import 'package:aiapparel/features/pages/settings/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../authentication/controllers/user/user_controller.dart';
import 'edits/change_dob.dart';
import 'edits/change_phone_number.dart';
import 'edits/change_username.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const AAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image =
                        networkImage.isNotEmpty ? networkImage : AImages.user;
                    return controller.imageUploading.value
                        ? const AShimmerEffect(
                            width: 80, height: 80, radius: 80)
                        : ACircularImage(
                            image: image,
                            width: 80,
                            height: 80,
                            isNetworkImage: networkImage.isNotEmpty);
                  }),
                  TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture')),
                ],
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: ASizes.spaceBtwItems),
            const ASectionHeading(
                title: 'Profile Information', showActionButton: false),
            const SizedBox(height: ASizes.spaceBtwItems),
            AProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName())),
            AProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () => Get.to(() => const ChangeUsername())),
            const SizedBox(height: ASizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: ASizes.spaceBtwItems),
            const ASectionHeading(
                title: 'Personal Information', showActionButton: false),
            AProfileMenu(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: controller.user.value.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User ID copied to clipboard'),
                    ),
                  );
                },
                title: 'User ID',
                icon: Iconsax.copy,
                value: controller.user.value.id),
            AProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                icon: Icons.email,
                value: controller.user.value.email),
            AProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () => Get.to(() => const ChangePhoneNumber())),
            AProfileMenu(
                title: 'Gender',
                value: controller.user.value.gender,
                onPressed: () => Get.to(() => const ChangeGender())),
            AProfileMenu(
                title: 'Date of Birth',
                value: controller.user.value.dob,
                onPressed: () => Get.to(() => const ChangeDOB())),
            const Divider(),
            const SizedBox(height: ASizes.spaceBtwItems),
            Center(
              child: OutlinedButton(
                onPressed: () => controller.deleteAccountWarningPopup(),
                child: const Text('Delete Account',
                    style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
