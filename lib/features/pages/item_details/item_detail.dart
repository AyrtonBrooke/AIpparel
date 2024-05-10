import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:aiapparel/common/widgets/heading/section_heading.dart';
import 'package:aiapparel/common/widgets/icons/circular_icon.dart';
import 'package:aiapparel/common/widgets/images/rounded_images.dart';
import 'package:aiapparel/features/pages/home/models/item_model.dart';
import 'package:aiapparel/features/pages/item_details/widgets/item_detail_image_slider.dart';
import 'package:aiapparel/features/pages/item_details/widgets/item_meta_data.dart';
import 'package:aiapparel/features/pages/item_details/widgets/rating_share_widget.dart';
import 'package:aiapparel/utils/constants/colors.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AItemImageSlider(item: item),

            Padding(
              padding: const EdgeInsets.only(right: ASizes.defaultSpace, left: ASizes.defaultSpace, bottom: ASizes.defaultSpace),
              child: Column(
                children: [
                  const ARatingAndShare(),

                  AItemMetaData(item: item),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


