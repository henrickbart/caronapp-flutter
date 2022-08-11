import 'package:caronapp/model/response/groupResponse.model.dart';
import 'package:caronapp/service/group.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customGenericList.widget.dart';
import 'package:caronapp/widget/customGenericListItem.widget.dart';
import 'package:caronapp/widget/customListLoader.widget.dart';
import 'package:caronapp/widget/customMainCard.widget.dart';
import 'package:caronapp/widget/customNotificationState.widget.dart';
import 'package:caronapp/widget/customTopBar.widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../service/base.service.dart';
import 'base.page.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  GroupService? service;
  List<GroupResponse> _groups = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    if (service == null) {
      service = Provider.of<GroupService>(context);
      loadList(false);
    }
    return Scaffold(
      appBar: CustomTopBar(
        context: context,
        showAsset: false,
        title: "Grupos",
        customActions: [
          Visibility(
            visible: service!.state == NotifierState.loaded,
            child: IconButton(
              onPressed: () => buildModalBottomSheet(),
              icon: const Icon(Icons.add),
              iconSize: 32.r,
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 300,
        onRefresh: () => loadList(),
        child: BasePage(
          useHorizontalPadding: true,
          child: CustomListLoader(
            notifierState: service!.state,
            buildLoadedList: () => buildLoadedList(context),
            buildLoadingList: () => buildLoadingList(context),
            emptyList: _groups.isEmpty,
            emptyState: buildEmptyState(),
            failureState: buildFailureState(),
          ),
        ),
      ),
    );
  }

  //Função para carregar a lista de grupos da API
  Future<void> loadList([bool notifyListener = true]) async {
    _groups = await service!.getUserGroups(notifyListener);
  }

  ///Método para renderizar o widget de empty state
  CustomNotificationState buildEmptyState() {
    return const CustomNotificationState(asset: 'assets/empty_state_group.svg', assetSize: 8, title: 'Você não participa de nenhum grupo', subtitle: 'Crie ou participe de grupos clicando no "+" acima');
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
      itemCount: _groups.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: Theme.of(context).rowSize),
            CustomMainCard(
              text: _groups[index].name,
              index: index,
              onTap: () => Navigator.pushNamed(context, groupDetail, arguments: [_groups[index], index]),
            )
          ],
        );
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
        return Column(
          children: [SizedBox(height: Theme.of(context).rowSize), CustomMainCard.loading()],
        );
      },
    );
  }

  ///Constroi barra de seleção embaixo da tela
  buildModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CustomGenericList(list: [
            CustomGenericListItem(
              title: "Criar novo grupo",
              index: 0,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, groupAdd).then((value) => loadList());
              },
            ),
            CustomGenericListItem(
              title: "Entrar usando código",
              index: 0,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, groupAddByCode).then((value) => loadList());
              },
            ),
          ]);
        });
  }
}
