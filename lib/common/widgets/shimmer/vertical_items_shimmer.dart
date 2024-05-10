import 'package:aiapparel/common/layouts/grid_layout.dart';
import 'package:aiapparel/common/widgets/shimmer/shimmer.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AVerticalItemShimmer extends StatelessWidget {
  const AVerticalItemShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return AGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AShimmerEffect(width: 180, height: 180),
            SizedBox(height: ASizes.spaceBtwItems),
            AShimmerEffect(width: 160, height: 15),
            SizedBox(height: ASizes.spaceBtwItems),
            AShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
