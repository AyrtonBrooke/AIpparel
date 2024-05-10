import 'package:aiapparel/common/widgets/heading/section_heading.dart';
import 'package:aiapparel/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../home/controllers/upload_controller.dart';
import 'package:get/get.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadController());
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Upload Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  const ASectionHeading(title: 'Uploads', showActionButton: false),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  ASettingsMenuTile(
                    icon: Iconsax.square,
                    title: 'Upload Categories',
                    subTitle: '',
                    onTap: controller.uploadCategories,
                    trailing:
                        const Icon(Iconsax.arrow_circle_up3), // Add icon at the end
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  const ASettingsMenuTile(
                    icon: Iconsax.component,
                    title: 'Upload Brands',
                    subTitle: '',
                    trailing:
                        Icon(Iconsax.arrow_circle_up3), // Add icon at the end
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  ASettingsMenuTile(
                    icon: Iconsax.shop,
                    title: 'Upload Banners',
                    subTitle: '',
                    trailing:
                        Icon(Iconsax.arrow_circle_up3), // Add icon at the end
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  ASettingsMenuTile(
                    icon: Iconsax.square, title: 'Upload Items', subTitle: '',
                    trailing:
                        Icon(Iconsax.arrow_circle_up3), // Add icon at the end
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
