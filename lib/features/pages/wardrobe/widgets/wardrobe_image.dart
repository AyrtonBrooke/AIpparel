import 'package:aiapparel/features/pages/home/controllers/images_controller.dart';
import 'package:aiapparel/features/pages/home/models/wardrobe_model.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class AWardrobeImage extends StatelessWidget {
  const AWardrobeImage({
    super.key,
    required this.item,
  });

  final WardrobeModel item;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    final controller = Get.put(ImageController());

    return ACurvedEdgeWidget(
      child: Container(
        color: dark ? AColors.darkerGrey : AColors.light,
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => controller.showEnlargedImage(item.image),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),  // Adjust this value to match your curved edges
                  child: CachedNetworkImage(
                    imageUrl: item.image, // Use thumbnail URL here
                    height: 400,  // You can adjust this height or make it responsive
                    width: double.infinity,  // Takes full width available
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AColors.primary),
                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),

                  ),
                ),
              ),
            ),
            const AAppBar(
              showBackArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}
