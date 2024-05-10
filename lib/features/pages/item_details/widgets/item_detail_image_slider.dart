import 'package:aiapparel/features/pages/home/controllers/images_controller.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../home/models/item_model.dart';
import 'package:get/get.dart';

import 'favourite_icon.dart';

class AItemImageSlider extends StatelessWidget {
  const AItemImageSlider({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    final controller = Get.put(ImageController());

    return ACurvedEdgeWidget(
      child: Container(
        color: dark ? AColors.darkerGrey : AColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(ASizes.itemImageRadius * 2),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => controller.showEnlargedImage(item.thumbnail),
                      child: CachedNetworkImage(
                        imageUrl: item.thumbnail, // Use thumbnail URL here
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: AColors.primary),
                      ),
                    ),
                  ),
                )),
            AAppBar(
              showBackArrow: true,
              actions: [
                AFavouriteIcon(itemId: item.id),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
