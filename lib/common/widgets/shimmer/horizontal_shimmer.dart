import 'package:aiapparel/common/widgets/shimmer/shimmer.dart';
import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AHorizontalItemShimmer extends StatelessWidget {
  const AHorizontalItemShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ASizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            const SizedBox(width: ASizes.spaceBtwSections),
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AShimmerEffect(width: 120, height: 120),
            SizedBox(width: ASizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AShimmerEffect(width: 180, height: 180),
                SizedBox(height: ASizes.spaceBtwItems),
                AShimmerEffect(width: 160, height: 15),
                SizedBox(height: ASizes.spaceBtwItems),
                AShimmerEffect(width: 110, height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
