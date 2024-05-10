
import 'package:aiapparel/features/pages/wardrobe/widgets/wardrobe_image.dart';
import 'package:aiapparel/features/pages/wardrobe/widgets/wardrobe_metadata.dart';
import 'package:flutter/material.dart';


import '../../../utils/constants/sizes.dart';
import '../home/models/wardrobe_model.dart';

class WardrobeDetail extends StatelessWidget {
  const WardrobeDetail({super.key, required this.item});

  final WardrobeModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AWardrobeImage(item: item),

            Padding(
              padding: const EdgeInsets.only(right: ASizes.defaultSpace, left: ASizes.defaultSpace, bottom: ASizes.defaultSpace),
              child: AWardrobeMetaData(item: item),
            ),
          ],
        ),
      ),
    );
  }
}


