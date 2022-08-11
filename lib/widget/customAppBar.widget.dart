import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'customAppBarAction.widget.dart';

///Classe responsável por criar um AppBar customizado com um tamanho maior que o usual
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final List<Widget> customActions;

  const CustomAppBar({
    Key? key,
    required this.context,
    required this.title,
    this.customActions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: Theme.of(context).orientedSize(1.0), right: Theme.of(context).orientedSize(1.0)),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ModalRoute.of(context)?.canPop == true
                    ? CustomAppBarAction(
                        icon: Icons.arrow_back,
                        function: () => Navigator.of(context).pop(),
                      )
                    : SizedBox(
                        width: Theme.of(context).columnSize / 2,
                      ),
                SizedBox(width: Theme.of(context).orientedSize(1.0)),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.appBarTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ...customActions
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary);
  }

  ///Propriedade para obter o tamanho personalizado da appBar
  @override
  Size get preferredSize => SizerUtil.orientation == Orientation.portrait ? Size.fromHeight(Theme.of(context).rowSize * 3) : Size.fromHeight(Theme.of(context).rowSize * appBarSizeLandscape);
}
