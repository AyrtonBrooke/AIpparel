import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ARoundedContainer extends StatelessWidget {
  const ARoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = ASizes.cardRadiusLg,
      this.child,
      this.showBorder = false,
      this.borderColor = AColors.borderPrimary,
      this.backgroundColor = AColors.white,
      this.padding,
      this.margin});

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
