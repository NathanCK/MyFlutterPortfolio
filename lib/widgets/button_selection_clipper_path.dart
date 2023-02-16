import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/math_utils.dart';

class ButtonSelectionClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.arcTo(
      Rect.fromLTWH(0, 0, size.width - 110, size.height),
      MathUtils.degreeToRadians(90),
      MathUtils.degreeToRadians(-180),
      true,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
