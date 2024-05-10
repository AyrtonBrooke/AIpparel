import 'package:aiapparel/common/widgets/icons/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../home/controllers/favourites_controller.dart';

class AFavouriteIcon extends StatelessWidget {
  const AFavouriteIcon({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => ACircularIcon(
        icon: controller.isFavourite(itemId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(itemId) ? AColors.error : null,
        onPressed: () => controller.toggleFavouriteItem(itemId),
      ),
    );
  }
}
