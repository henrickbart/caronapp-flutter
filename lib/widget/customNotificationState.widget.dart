import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

///Classe responsável por renderizar um widget de notificação de estado/falha
class CustomNotificationState extends StatelessWidget {
  final String? asset;
  final String title;
  final String? subtitle;
  final bool isAssetLottie;
  final double? assetSize;
  final bool useHorizontalPadding;

  const CustomNotificationState({
    Key? key,
    this.asset,
    required this.title,
    this.subtitle,
    this.isAssetLottie = false,
    this.assetSize = 4,
    this.useHorizontalPadding = false,
  }) : super(key: key);

  const CustomNotificationState.failure({
    Key? key,
    this.asset = 'assets/failure_state.svg',
    this.assetSize = 8,
    this.isAssetLottie = false,
    this.title = 'Ops! Algo deu errado',
    this.subtitle = 'Parece que tivemos um problema. Tente novamente',
    this.useHorizontalPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: useHorizontalPadding ? Theme.of(context).columnSize : 0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              asset != null ? buildImage(context) : const SizedBox(),
              Text(
                title,
                style: Theme.of(context).textTheme.homeSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.0.s),
              subtitle != null
                  ? Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return SizerUtil.orientation == Orientation.portrait
        ? Column(
            children: [
              isAssetLottie
                  ? Lottie.asset(
                      asset!,
                    )
                  : SvgPicture.asset(
                      asset!,
                      height: Theme.of(context).rowSize * assetSize!,
                    ),
              SizedBox(height: 12.0.s),
            ],
          )
        : const SizedBox();
  }
}
