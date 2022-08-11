import 'dart:typed_data';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customGradientIcon.widget.dart';
import 'package:flutter/material.dart';

class CustomAvatarImage extends StatelessWidget {
  const CustomAvatarImage({
    Key? key,
    this.imageBytes,
    required this.size,
    this.onTap,
  }) : super(key: key);

  final Uint8List? imageBytes;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            image: imageBytes != null
                ? DecorationImage(
                    image: Image.memory(imageBytes!).image,
                    fit: BoxFit.fill,
                  )
                : null,
            borderRadius: const BorderRadius.all(
              Radius.elliptical(200, 200),
            ),
          ),
          child: imageBytes == null ? GradientIcon(Icons.person, size: size * 3 / 5) : null,
        ),
        Positioned.fill(
            child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.gradientAvatarImage,
            borderRadius: const BorderRadius.all(
              Radius.elliptical(200, 200),
            ),
          ),
        )),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100.0.r),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
