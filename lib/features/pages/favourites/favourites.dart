import 'package:aiapparel/common/widgets/cards/vertical_card.dart';
import 'package:aiapparel/common/widgets/icons/circular_icon.dart';
import 'package:aiapparel/features/pages/home/controllers/favourites_controller.dart';
import 'package:aiapparel/navigation_menu.dart';
import 'package:aiapparel/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../common/layouts/grid_layout.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../common/widgets/shimmer/vertical_items_shimmer.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Scaffold(
      appBar: AAppBar(
        title: Text('Favourites',
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ACircularIcon(
              icon: Iconsax.add, onPressed: () => Get.offAll(const NavigationMenu()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                future: controller.favouriteItems(),
                builder: (context, snapshot) {
                  final emptyWidget = AAnimationLoaderWidget(
                    text: 'Whoops! Favourites Empty',
                    animation: AImages.success,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () =>
                        Get.offAll(() => const NavigationMenu()),
                  );
                  const loader = AVerticalItemShimmer(itemCount: 6);
                  final widget = ACloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);
                  if (widget != null) return widget;

                  final items = snapshot.data!;
                  return AGridLayout(
                      itemCount: items.length,
                      itemBuilder: (_, index) =>
                          AVerticalCard(item: items[index]));
                }),
          ),
        ),
      ),
    );
  }
}
