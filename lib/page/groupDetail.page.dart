import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/service/carona.service.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../model/response/caronaResponse.model.dart';
import '../model/response/groupResponse.model.dart';
import '../util/background.util.dart';
import '../widget/customAppBarAction.widget.dart';
import '../widget/customCaronaItem.widget.dart';
import '../widget/customListLoader.widget.dart';
import '../widget/customNotificationState.widget.dart';
import '../widget/customSnackBar.widget.dart';

class GroupDetailPage extends StatefulWidget {
  const GroupDetailPage({Key? key, required this.model, required this.index}) : super(key: key);

  final GroupResponse model;
  final int index;

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  CaronaService? _service;
  List<CaronaResponse> _caronas = List.empty(growable: true);

  bool _isSearch = true;

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      _service = Provider.of<CaronaService>(context);
      loadList(false);
    }

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        floatingActionButton: Visibility(
          visible: _service!.state == NotifierState.loaded,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, caronaAddPage, arguments: [widget.model.id]).then((value) => loadList()),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: Theme.of(context).rowSize * (SizerUtil.orientation == Orientation.portrait ? 10 : 18),
              decoration: BoxDecoration(
                image: DecorationImage(image: Image.asset(Background.getAssetName(widget.index)).image, fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize, vertical: Theme.of(context).rowSize / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ModalRoute.of(context)?.canPop == true
                              ? CustomAppBarAction(
                                  icon: Icons.arrow_back,
                                  function: () => Navigator.of(context).pop(),
                                )
                              : SizedBox(),
                          CustomAppBarAction(
                            icon: Icons.share,
                            function: () => showShareCodeDialog(context, widget.model.shareCode),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Theme.of(context).rowSize),
                    child: Center(child: Text(widget.model.name, style: Theme.of(context).textTheme.profileSubtitle)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LiquidPullToRefresh(
                color: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                showChildOpacityTransition: false,
                springAnimationDurationInMilliseconds: 300,
                onRefresh: () => loadList(),
                child: CustomListLoader(
                  notifierState: _service!.state,
                  emptyList: _caronas.isEmpty,
                  buildLoadedList: () => buildLoadedList(context),
                  buildLoadingList: () => buildLoadingList(context),
                  emptyState: buildEmptyState(),
                  failureState: buildFailureState(),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  //Função para carregar a lista de caronas da API
  Future<void> loadList([bool notifyListener = true]) async {
    _isSearch = true;
    _caronas = await _service!.searchCaronasByGroup(widget.model.id, notifyListener);
    _isSearch = false;
  }

  ///Método para renderizar o widget de empty state
  CustomNotificationState buildEmptyState() {
    return const CustomNotificationState(asset: 'assets/empty_state_carona.svg', assetSize: 8, useHorizontalPadding: true, title: '', subtitle: 'Não encontramos nenhuma carona disponível para esse grupo');
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
        return Column(
          children: [
            CustomCaronaItem(
              model: _caronas[index],
              showSeats: true,
              onTap: () => showConfirmationDialog(context, _caronas[index].id),
            ),
            SizedBox(height: Theme.of(context).rowSize / 2),
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
        return _isSearch
            ? Column(
                children: [
                  CustomCaronaItem.loading(showDivider: false, showSeats: true),
                  SizedBox(height: Theme.of(context).rowSize / 2),
                ],
              )
            : Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).columnSize * 7,
                  vertical: Theme.of(context).columnSize * 7,
                ),
                child: const CircularProgressIndicator(),
              );
      },
    );
  }

  ///Método para exigir a confirmação do usuário
  showConfirmationDialog(BuildContext context, int caronaID) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reservar carona'),
        content: const Text('Tem certeza que deseja reservar essa carona?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('CANCELAR', style: TextStyle(fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily, color: Theme.of(context).colorScheme.disabled))),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                bookCarona(caronaID);
              },
              child: Text('CONFIRMAR', style: TextStyle(fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily, color: Theme.of(context).colorScheme.primary))),
        ],
      ),
    );
  }

  ///Método para exibir o código de compartilhamento do grupo
  showShareCodeDialog(BuildContext context, String shareCode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Código de compartilhamento',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        content: Container(alignment: Alignment.center, height: Theme.of(context).rowSize * 2, child: Text(shareCode, style: Theme.of(context).textTheme.shareCode)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('CANCELAR', style: TextStyle(fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily, color: Theme.of(context).colorScheme.disabled))),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Clipboard.setData(ClipboardData(text: shareCode));
              },
              child: Text('COPIAR', style: TextStyle(fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily, color: Theme.of(context).colorScheme.primary))),
        ],
      ),
    );
  }

  void bookCarona(int caronaID) async {
    await _service!.bookCarona(caronaID);
    if (!mounted) return;

    if (_service!.state == NotifierState.loaded) {
      showSnackBar(context, const CustomSnackBar.success(message: 'Carona reservada com sucesso'));
      loadList();
    } else if (_service!.state == NotifierState.failure) {
      showSnackBar(context, CustomSnackBar.error(message: _service!.failure!.message));
    }
  }
}
