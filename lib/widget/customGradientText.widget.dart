import 'package:caronapp/util/colors.util.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText({Key? key, required this.text, this.apply = true}) : super(key: key);

  final Text text;
  final bool apply;

  @override
  Widget build(BuildContext context) {
    return apply
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => Theme.of(context).colorScheme.gradient.createShader(bounds),
            child: text,
          )
        : text;
  }
}
