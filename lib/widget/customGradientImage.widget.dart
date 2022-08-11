import 'package:caronapp/util/colors.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientImage extends StatelessWidget {
  const GradientImage(this.assetImage, {Key? key, required this.size, this.active = true}) : super(key: key);

  final String assetImage;
  final double size;
  final bool active;

  @override
  Widget build(BuildContext context) {
    var image = SvgPicture.asset(
      assetImage,
      height: size,
      color: Theme.of(context).colorScheme.disabled,
    );

    return active ? ShaderMask(blendMode: BlendMode.srcIn, shaderCallback: (bounds) => Theme.of(context).colorScheme.gradient.createShader(bounds), child: image) : image;
  }
}
