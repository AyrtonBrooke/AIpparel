import 'package:aiapparel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ASpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: ASizes.appBarHeight,
    left: ASizes.defaultSpace,
    bottom: ASizes.defaultSpace,
    right: ASizes.defaultSpace,
  );
}