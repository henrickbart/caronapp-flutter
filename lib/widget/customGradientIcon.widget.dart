import 'package:caronapp/util/colors.util.dart';
import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.iconData, {
    Key? key,
    required this.size,
  }) : super(key: key);

  final IconData? iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => Theme.of(context).colorScheme.gradient.createShader(bounds),
        child: Icon(
          iconData,
          size: size,
        ));
  }
}
