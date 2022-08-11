import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../util/background.util.dart';

class CustomMainCard extends StatelessWidget {
  CustomMainCard({
    Key? key,
    required this.text,
    required this.onTap,
    this.imageAsset,
    this.index,
  }) : super(key: key);

  CustomMainCard.loading({
    Key? key,
    this.text = '',
    this.imageAsset,
    this.index,
  })  : onTap = (() {}),
        super(key: key) {
    loading = true;
  }

  final String text;
  final VoidCallback onTap;
  final String? imageAsset;
  final int? index;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? buildLoading(context) : buildData(context);
  }

  /// Método para renderizar o card após as informações terem sido carregadas
  Widget buildData(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Theme.of(context).colorScheme.surface,
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0.s)),
          child: Container(
            height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 6 : 11),
            width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 13 : 6),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(imageAsset != null ? imageAsset! : Background.getAssetName(index!)).image,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0.r),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.50),
              borderRadius: BorderRadius.circular(20.0.r),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 25,
          child: Text(
            text,
            style: Theme.of(context).textTheme.mainCardText,
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0.r),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }

  ///Método para renderizar o card enquanto está sendo feito o carregamento (exibe o shimmer effect)
  Widget buildLoading(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0.s)),
      child: Container(
        height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 6 : 11),
        width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 13 : 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.s),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: Theme.of(context).rowSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 1)),
                Container(
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 8 : 3),
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: Theme.of(context).rowSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 1)),
                Container(
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 2 : 3),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
