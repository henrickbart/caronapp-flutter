import 'package:caronapp/page/base.page.dart';
import 'package:caronapp/util/authorization.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customAvatarImage.widget.dart';
import 'package:caronapp/widget/customGradientIcon.widget.dart';
import 'package:caronapp/widget/customGradientImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../widget/customTopBar.widget.dart';
import '../widget/customMainCard.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBar(
        context: context,
        showAsset: true,
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Theme.of(context).columnSize / 4),
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        'assets/logo_horizontal.svg',
                        height: Theme.of(context).rowSize * (orientation == Orientation.portrait ? 3 / 4 : 3 / 2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Theme.of(context).columnSize / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Text(
                              "Olá,\n${Authorization.info!.name}!",
                              style: Theme.of(context).textTheme.homeTitle,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: Theme.of(context).columnSize,
                              )),
                          Flexible(
                            flex: 3,
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  'assets/photo_placeholder.svg',
                                  height: Theme.of(context).rowSize * (orientation == Orientation.portrait ? 4 : 8),
                                ),
                                Positioned(
                                  left: 10,
                                  top: 10,
                                  child: CustomAvatarImage(
                                    size: Theme.of(context).rowSize * (orientation == Orientation.portrait ? 3 : 6),
                                    onTap: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("O que deseja fazer hoje?", style: Theme.of(context).textTheme.homeSubtitle),
                    SizedBox(height: Theme.of(context).rowSize),
                    Wrap(
                      runSpacing: Theme.of(context).rowSize,
                      spacing: Theme.of(context).columnSize / 2,
                      children: [
                        CustomMainCard(text: "Procurar caronas", imageAsset: "assets/search_carona.jpg", onTap: () => Navigator.pushNamed(context, caronaSearchPage)),
                        CustomMainCard(text: "Oferecer caronas", imageAsset: "assets/create_carona.jpg", onTap: () => Navigator.pushNamed(context, caronaAddPage)),
                      ],
                    ),
                    SizedBox(
                      height: Theme.of(context).rowSize,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
