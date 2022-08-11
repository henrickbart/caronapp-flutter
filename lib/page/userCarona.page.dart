import 'package:caronapp/model/response/caronaResponse.model.dart';
import 'package:caronapp/model/response/groupResponse.model.dart';
import 'package:caronapp/service/carona.service.dart';
import 'package:caronapp/service/group.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customCaronaItem.widget.dart';
import 'package:caronapp/widget/customListLoader.widget.dart';
import 'package:caronapp/widget/customMainCard.widget.dart';
import 'package:caronapp/widget/customNotificationState.widget.dart';
import 'package:caronapp/widget/customTopBar.widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../widget/customSnackBar.widget.dart';
import 'base.page.dart';

class UserCaronaPage extends StatefulWidget {
  const UserCaronaPage({Key? key}) : super(key: key);

  @override
  State<UserCaronaPage> createState() => _UserCaronaPageState();
}

class _UserCaronaPageState extends State<UserCaronaPage> {
  CaronaService? _service;
  List<CaronaResponse> _caronas = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      _service = Provider.of<CaronaService>(context);
      loadList(false);
    }
    return Scaffold(
      appBar: CustomTopBar(
        context: context,
        showAsset: false,
        title: "Minhas caronas",
      ),
      body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 300,
        onRefresh: () => loadList(),
        child: BasePage(
          child: CustomListLoader(
            notifierState: _service!.state,
            buildLoadedList: () => buildLoadedList(context),
            buildLoadingList: () => buildLoadingList(context),
            emptyList: _caronas.isEmpty,
            emptyState: buildEmptyState(),
            failureState: buildFailureState(),
          ),
        ),
      ),
    );
  }

  //Função para carregar a lista de caronas da API
  Future<void> loadList([bool notifyListener = true]) async {
    _caronas = await _service!.getCaronas(notifyListener);
  }

  ///Método para renderizar o widget de empty state
  CustomNotificationState buildEmptyState() {
    return const CustomNotificationState(asset: 'assets/empty_state_carona.svg', assetSize: 8, title: 'Você ainda não participou de nenhuma carona', subtitle: 'Busque ou ofereça caronas na tela inicial');
  }

  ///Método para renderizar o widget de erro
  CustomNotificationState buildFailureState() {
    return const CustomNotificationState.failure();
  }

  ///Método para renderizar a lista após a tela ser carregada
  Widget buildLoadedList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: _caronas.length,
      itemBuilder: (context, index) {
        return CustomCaronaItem(
            model: _caronas[index],
            showDivider: true,
            onTap: () => showSnackBar(
                context,
                const CustomSnackBar.info(
                  message: "Opa, vai com calma! Isso é só um trabalho de faculdade 😎",
                )));
      },
    );
  }

  ///Método para renderizar a lista enquanto a tela está sendo carregada
  Widget buildLoadingList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return CustomCaronaItem.loading(showDivider: true);
      },
    );
  }
}
