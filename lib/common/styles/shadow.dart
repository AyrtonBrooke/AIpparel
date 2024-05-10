import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class AShadowStyle {

  static final verticalShadow = BoxShadow(
    color: AColors.darkerGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontalShadow = BoxShadow(
      color: AColors.darkerGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );
}