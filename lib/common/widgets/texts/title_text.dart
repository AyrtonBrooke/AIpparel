import 'package:flutter/material.dart';

class ATitleText extends StatelessWidget {
  const ATitleText(
      {super.key,
      required this.title,
      this.smallSize = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.left});

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
        style: smallSize
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.titleSmall);
  }
}
