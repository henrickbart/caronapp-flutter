import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

///Estrutura basica das paginas da aplicação
class BasePage extends StatelessWidget {
  final Widget? child;
  final bool useHorizontalPadding;
  final bool useVerticalPadding;

  const BasePage({
    Key? key,
    required this.child,
    this.useHorizontalPadding = false,
    this.useVerticalPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return SafeArea(
        minimum: EdgeInsets.symmetric(
          ///Propriedade que calcula o padding horizontal da tela, quando useHorizontalPadding estiver ligado
          horizontal: useHorizontalPadding ? (SizerUtil.orientation == Orientation.portrait ? Theme.of(context).columnSize : Theme.of(context).columnSize * 2) : 0,

          ///Propriedade que calcula o padding vertical da tela, quando useVerticalPadding estiver ligado
          vertical: useVerticalPadding ? Theme.of(context).rowSize * 1 : 0,
        ),
        child: Container(
          alignment: Alignment.topCenter,
          width: SizerUtil.orientation == Orientation.portrait ? 100.0.w : 100.0.h,
          child: child,
        ),
      );
    });
  }
}
