import 'package:caronapp/model/response/userVehicleResponse.model.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customGradientImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomVehicleItem extends StatelessWidget {
  CustomVehicleItem({
    Key? key,
    this.model,
    required this.onTap,
  }) : super(key: key);

  CustomVehicleItem.loading({
    Key? key,
    this.model,
  })  : onTap = (() {}),
        super(key: key) {
    loading = true;
  }

  final UserVehicleResponse? model;
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
          padding: EdgeInsets.symmetric(
            horizontal: Theme.of(context).columnSize,
            vertical: Theme.of(context).rowSize,
          ),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model!.brand.toUpperCase(), style: Theme.of(context).textTheme.vehicleLabel),
                        Text(model!.model.toUpperCase(), style: Theme.of(context).textTheme.vehicleContent),
                        SizedBox(height: 12.s),
                        Text("PLACA", style: Theme.of(context).textTheme.vehicleLabel),
                        Text(model!.plate.toUpperCase(), style: Theme.of(context).textTheme.vehicleContent),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: model!.photo != null ? Image.memory(model!.photo!) : Image.asset('assets/car_placeholder.png', height: 96.s),
                  )
                ],
              ),
              SizedBox(height: 12.s),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemInfo(context, 'assets/icon_color.svg', 'COR', model!.color.toUpperCase()),
                  buildItemInfo(context, 'assets/icon_calendar.svg', 'ANO', model!.year.toUpperCase()),
                  buildItemInfo(context, 'assets/icon_seat.svg', 'LUGARES', model!.seats.toString()),
                ],
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }

  //Método para renderizar uma informação do card
  Widget buildItemInfo(BuildContext context, String assetName, String label, String content) {
    return Row(
      children: [
        GradientImage(assetName, size: 28.r, active: true),
        SizedBox(width: 3.r),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.vehicleInfoLabel),
            Text(content, style: Theme.of(context).textTheme.vehicleInfoContent),
          ],
        ),
      ],
    );
  }

  ///Método para renderizar o card enquanto está sendo feito o carregamento (exibe o shimmer effect)
  Widget buildLoading(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 6.5 : 13),
      padding: EdgeInsets.symmetric(
        horizontal: Theme.of(context).columnSize,
        vertical: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
      ),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                      width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 4.5 : 3),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: Theme.of(context).rowSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 1)),
                    Container(
                      height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                      width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 4.5 : 3),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                Container(
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 2.5 : 5),
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 4.5 : 2.5),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            SizedBox(height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 3 : 2),
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  color: Theme.of(context).colorScheme.primary,
                ),
                Container(
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 3 : 2),
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  color: Theme.of(context).colorScheme.primary,
                ),
                Container(
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 3 : 2),
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
