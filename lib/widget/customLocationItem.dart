import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomLocationItem extends StatelessWidget {
  CustomLocationItem({
    Key? key,
    this.model,
    required this.onTap,
  }) : super(key: key);

  CustomLocationItem.loading({
    Key? key,
    this.model,
  })  : onTap = (() {}),
        super(key: key) {
    loading = true;
  }

  final LocationResponse? model;
  final VoidCallback onTap;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? buildLoading(context) : buildData(context);
  }

  /// Método para renderizar o card após as informações terem sido carregadas
  Widget buildData(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize),
          child: Padding(
            padding: EdgeInsets.only(top: 18.s),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model!.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.locationTitle,
                          ),
                          SizedBox(height: 2.5.s),
                          Text(
                            model!.cityState,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.locationSubtitle,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.disabled,
                      size: 24.s,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Theme.of(context).rowSize / 3),
                  child: Divider(
                    color: Theme.of(context).colorScheme.disabled,
                    thickness: 1,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }

  ///Método para renderizar o card enquanto está sendo feito o carregamento (exibe o shimmer effect)
  Widget buildLoading(BuildContext context) {
    return Container(
      height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 3.5 : 7),
      width: Theme.of(context).maxWidth,
      padding: EdgeInsets.only(left: Theme.of(context).columnSize, right: Theme.of(context).columnSize, top: Theme.of(context).rowSize),
      color: Theme.of(context).colorScheme.surface,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 8 : 5),
              height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 0.75 : 1.5),
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 2.5.s),
            Container(
              width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 6 : 3),
              height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 0.75 : 1.5),
              color: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: EdgeInsets.only(top: Theme.of(context).rowSize / 4),
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
