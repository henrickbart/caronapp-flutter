import 'package:caronapp/util/authorization.util.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customAvatarImage.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 10 : 18),
                decoration: BoxDecoration(gradient: Theme.of(context).colorScheme.gradient),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SafeArea(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize, vertical: Theme.of(context).rowSize / 2),
                      child: Text(
                        "Meu perfil",
                        style: Theme.of(context).textTheme.appBarTitle3,
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Theme.of(context).rowSize / 2),
                      child: Center(child: CustomAvatarImage(size: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 3 : 6), onTap: () {})),
                    ),
                    Center(
                        child: Text(
                      Authorization.info!.name,
                      style: Theme.of(context).textTheme.profileSubtitle,
                    )),
                  ],
                ),
              ),
              buildTile(context, 'assets/icon_car.svg', "Cadastro de veículo", true, () => Navigator.pushNamed(context, userVehiclePage)),
              //buildTile(context, 'assets/icon_docs.svg', "Envio de CNH", true, () => Navigator.pushNamed(context, documentPage)),
              // Container(
              //   color: Theme.of(context).colorScheme.surface,
              //   padding: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize / 2),
              //   child: Divider(
              //     thickness: 1,
              //     color: Theme.of(context).disabledColor,
              //   ),
              // ),
              buildTile(context, 'assets/icon_power.svg', "Sair", false, () {
                Authorization.info = null;
                Navigator.pushReplacementNamed(context, loginRoute);
              }, true)
            ],
          ),
        ),
      );
    });
  }

  ListTile buildTile(BuildContext context, String asset, String text, bool showChevron, VoidCallback onTap, [bool isRed = false]) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.symmetric(vertical: 2.5.s, horizontal: 5.s),
        child: SvgPicture.asset(
          asset,
          height: 16.s,
          alignment: Alignment.center,
          color: isRed ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onEmpty,
        ),
      ),
      title: Text(
        text,
        style: isRed ? Theme.of(context).textTheme.bodyTextProfile2 : Theme.of(context).textTheme.bodyTextProfile,
      ),
      trailing: Visibility(
        visible: showChevron,
        child: Icon(
          Icons.chevron_right,
          size: 24.s,
          color: isRed ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onEmpty,
        ),
      ),
    );
  }
}
