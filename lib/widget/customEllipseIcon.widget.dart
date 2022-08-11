import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:caronapp/util/responsivity.util.dart';

///Classe responsável por renderizar um ícone em formato de elipse
class CustomEllipseIcon extends StatelessWidget {
  final double ellipseSize;
  final double iconHorizontalPosition;
  final double iconVerticalPosition;
  final Color ellipseColor;
  final Color iconColor;
  final IconData? iconData;
  final String? svgAsset;
  final VoidCallback? onTap;

  const CustomEllipseIcon({
    Key? key,
    required this.ellipseSize,
    required this.iconHorizontalPosition,
    required this.iconVerticalPosition,
    required this.ellipseColor,
    required this.iconColor,
    this.iconData,
    this.svgAsset,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: ellipseSize,
          height: ellipseSize,
          decoration: BoxDecoration(
            color: ellipseColor,
            borderRadius: const BorderRadius.all(Radius.elliptical(200, 200)),
          ),
        ),
        Positioned(
          height: ellipseSize,
          width: ellipseSize,
          left: iconHorizontalPosition,
          top: iconVerticalPosition,
          child: svgAsset != null
              ? Container(
                  padding: EdgeInsets.all(ellipseSize * (1 / 5)),
                  child: SvgPicture.asset(
                    svgAsset!,
                  ))
              : Icon(
                  iconData,
                  color: iconColor,
                  size: ellipseSize * (2 / 3),
                ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: const BorderRadius.all(Radius.elliptical(200, 200)),
            ),
          ),
        ),
      ],
    );
  }
}
