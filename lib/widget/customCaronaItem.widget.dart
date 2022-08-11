import 'package:caronapp/model/response/caronaResponse.model.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customAvatarImage.widget.dart';
import 'package:caronapp/widget/customGradientImage.widget.dart';
import 'package:caronapp/widget/customGradientText.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../util/formaters.util.dart';

class CustomCaronaItem extends StatelessWidget {
  CustomCaronaItem({Key? key, this.model, required this.onTap, this.showDivider = false, this.showSeats = false}) : super(key: key);

  CustomCaronaItem.loading({Key? key, this.model, this.showDivider = false, this.showSeats = false})
      : onTap = (() {}),
        super(key: key) {
    loading = true;
  }

  final CaronaResponse? model;
  final bool showDivider;
  final bool showSeats;
  final VoidCallback onTap;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? buildLoading(context) : buildData(context);
  }

  /// Método para renderizar o card após as informações terem sido carregadas
  Widget buildData(BuildContext context) {
    var isRunning = model!.beginDate != null && model!.endDate == null;
    var hasEnded = model!.beginDate != null && model!.endDate != null;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Theme.of(context).columnSize / 2,
            right: Theme.of(context).columnSize / 2,
            top: 12.s,
          ),
          decoration: BoxDecoration(
            border: isRunning ? Border.all(color: Theme.of(context).colorScheme.secondary, width: 4.s) : null,
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Visibility(visible: isRunning, child: SizedBox(height: 20.s)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientText(
                        text: Text(Formaters.dateTimeToDateAndTime(model!.date), style: Theme.of(context).textTheme.titleCaronaCard),
                        apply: !hasEnded,
                      ),
                      GradientText(
                        text: Text(Formaters.doubleToCurrency(model!.price), style: Theme.of(context).textTheme.titleCaronaCard),
                        apply: !hasEnded,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.s),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: !hasEnded ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.disabled,
                          ),
                          Container(
                            height: 30.r,
                            width: 2.r,
                            decoration: BoxDecoration(
                              gradient: !hasEnded ? Theme.of(context).colorScheme.gradientSourceDestination : null,
                              color: Theme.of(context).colorScheme.disabled,
                            ),
                          ),
                          Icon(
                            Icons.gps_fixed,
                            color: !hasEnded ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.disabled,
                          ),
                        ],
                      ),
                      SizedBox(width: 10.s),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3.r),
                            Text(model!.origin.name, style: Theme.of(context).textTheme.bodyText1CaronaCard, overflow: TextOverflow.ellipsis),
                            SizedBox(height: 2.5.r),
                            Text(model!.origin.cityState, style: Theme.of(context).textTheme.bodyText2CaronaCard, overflow: TextOverflow.ellipsis),
                            SizedBox(height: 20.r),
                            Text(model!.destination.name, style: Theme.of(context).textTheme.bodyText1CaronaCard, overflow: TextOverflow.ellipsis),
                            SizedBox(height: 2.5.r),
                            Text(model!.destination.cityState, style: Theme.of(context).textTheme.bodyText2CaronaCard, overflow: TextOverflow.ellipsis),
                            Visibility(
                              visible: hasEnded,
                              child: Padding(
                                padding: EdgeInsets.only(right: 14.s),
                                child: Align(alignment: Alignment.centerRight, child: Text('ENCERRADA', style: Theme.of(context).textTheme.bodyText2CaronaCard, overflow: TextOverflow.ellipsis)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Theme.of(context).columnSize / 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAvatarImage(size: 32.s),
                    SizedBox(width: 12.s),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model!.driver.name,
                            style: Theme.of(context).textTheme.bodyText1CaronaCard,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            model!.driver.vehicle.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText3CaronaCard,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showSeats,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GradientImage('assets/icon_seat.svg', size: 20.s),
                              GradientText(
                                text: Text(model!.avaiableSeats.toString(), style: Theme.of(context).textTheme.bodyTextCaronaCard),
                              ),
                            ],
                          ),
                          Text('lugares disponíveis', style: Theme.of(context).textTheme.bodyText3CaronaCard)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Theme.of(context).columnSize / 2,
                  right: Theme.of(context).columnSize / 2,
                ),
                child: Visibility(
                  visible: !isRunning && showDivider,
                  child: Divider(
                    color: Theme.of(context).colorScheme.disabled,
                    thickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Visibility(
              visible: isRunning,
              child: Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.all(5.s),
                  child: Text(
                    'EM ANDAMENTO',
                    style: Theme.of(context).textTheme.topBarCaronaCard,
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: hasEnded,
          child: Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: Theme.of(context).colorScheme.gradientCaronaEnded),
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
        )
      ],
    );
  }

  ///Método para renderizar o card enquanto está sendo feito o carregamento (exibe o shimmer effect)
  Widget buildLoading(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 7.5 : 15),
      padding: EdgeInsets.only(
        left: Theme.of(context).columnSize / 2,
        right: Theme.of(context).columnSize / 2,
        top: 12.s,
      ),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 8 : 5),
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
            SizedBox(height: Theme.of(context).rowSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 1)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 2.5 : 5),
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 0.5),
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: Theme.of(context).columnSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 4)),
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
                      width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 3 : 2),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Theme.of(context).rowSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 8 : 5),
                  height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                  color: Theme.of(context).colorScheme.primary,
                ),
                Visibility(
                  visible: showSeats,
                  child: Container(
                    width: Theme.of(context).columnSize * (SizerUtil.orientation == Orientation.portrait ? 3 : 2),
                    height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 1 : 2),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: Theme.of(context).rowSize / (SizerUtil.orientation == Orientation.portrait ? 2 : 1)),
            Padding(
              padding: EdgeInsets.only(
                left: Theme.of(context).columnSize / 2,
                right: Theme.of(context).columnSize / 2,
              ),
              child: Visibility(
                visible: showDivider,
                child: Divider(
                  color: Theme.of(context).colorScheme.disabled,
                  thickness: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
