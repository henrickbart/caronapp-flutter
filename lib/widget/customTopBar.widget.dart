import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

///Classe responsável por criar um AppBar customizado com um tamanho maior que o usual
class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const CustomTopBar({
    Key? key,
    required this.context,
    required this.showAsset,
    this.title,
    this.customActions = const [],
  }) : super(key: key);

  final bool showAsset;
  final String? title;
  final List<Widget> customActions;

  @override
  Widget build(BuildContext context) {
    if (showAsset) {
      return Container(
        width: Theme.of(context).maxWidth,
        height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 4 : 8),
        child: SvgPicture.asset(
          'assets/top_bar.svg',
          fit: BoxFit.fill,
        ),
      );
    } else {
      return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.appBarTitle2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ...customActions
            ],
          ),
        ),
      );
    }
  }

  ///Propriedade para obter o tamanho personalizado da appBar
  @override
  Size get preferredSize => SizerUtil.orientation == Orientation.portrait ? Size.fromHeight(Theme.of(context).rowSize * 3) : Size.fromHeight(Theme.of(context).rowSize * appBarSizeLandscape);
}
