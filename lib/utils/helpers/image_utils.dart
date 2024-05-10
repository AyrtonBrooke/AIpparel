// lib/utils/image_utils.dart

import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:io';
import 'package:flutter/material.dart';

Future<String> getDominantColor(XFile image) async {
  final File imageFile = File(image.path);
  final ImageProvider imageProvider = FileImage(imageFile);

  final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
    imageProvider,
    maximumColorCount: 5,
  );

  final Color dominantColor = palette.dominantColor?.color ?? Colors.transparent;

  return closestColorName(dominantColor);
}

String closestColorName(Color color) {
  if (color.red > 200 && color.green < 100 && color.blue < 100) {
    return "Red";
  } else if (color.red < 100 && color.green < 100 && color.blue > 200) {
    return "Blue";
  } else if (color.red < 100 && color.green > 200 && color.blue < 100) {
    return "Green";
  } else if (color.red < 100 && color.green < 100 && color.blue < 100) {
    return "Black";
  } else {
    return "Unknown";
  }
}
