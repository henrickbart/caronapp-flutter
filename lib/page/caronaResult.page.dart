import 'package:caronapp/model/response/caronaResponse.model.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/service/carona.service.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customCaronaItem.widget.dart';
import 'package:caronapp/widget/customListLoader.widget.dart';
import 'package:caronapp/widget/customNotificationState.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/customAppBar.widget.dart';
import '../widget/customSnackBar.widget.dart';
import 'base.page.dart';

class CaronaResultPage extends StatefulWidget {
  const CaronaResultPage({
    Key? key,
    required this.originID,
    required this.destinationID,
    required this.date,
  }) : super(key: key);

  final int originID;
  final int destinationID;
  final DateTime date;

  @override
  State<CaronaResultPage> createState() => _CaronaResultPageState();
}

class _CaronaResultPageState extends State<CaronaResultPage> {
  CaronaService? _service;
  List<CaronaResponse> _caronas = List.empty(growable: true);

  bool _isSearch = true;

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      _service = Provider.of<CaronaService>(context);
      loadList(false);
    }
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Reservar carona'),
      body: BasePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: _service!.state == NotifierState.loaded,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Theme.of(context).columnSize, vertical: Theme.of(context).rowSize),
                child: Text(
                  _caronas.length > 1
                      ? '${_caronas.length} caronas encontradas'
                      : _caronas.isEmpty
                          ? 'Nenhuma carona encontrada'
                          : '${_caronas.length} carona encontrada',
                  style: Theme.of(context).textTheme.homeBody,
                ),
              ),
            ),
            Expanded(
              child: CustomListLoader(
                notifierState: _service!.state,
                buildLoadedList: () => buildLoadedList(context),
                buildLoadingList: () => buildLoadingList(context),
                emptyList: _caronas.isEmpty,
                emptyState: buildEmptyState(),
                failureState: buildFailureState(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Função para carregar a lista de caronas da API
  Future<void> loadList([bool notifyListener = true]) async {
    _isSearch = true;
    _caronas = await _service!.searchCaronas(widget.originID, widget.destinationID, widget.date, notifyListener);
    _isSearch = false;
  }

  ///Método para renderizar o widget de empty state
  CustomNotificationState buildEmptyState() {
    return const CustomNotificationState(asset: 'assets/empty_state_carona.svg', assetSize: 8, title: 'Não encontramos nenhuma carona disponível', subtitle: 'Tente alterar o filtro na página anterior');
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
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _isSearch
              ? const CustomNotificationState(
                  title: "Encontrando a carona perfeita para você...",
                  isAssetLottie: true,
                  asset: 'assets/search_carona_animation.json',
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).columnSize * 7,
                    vertical: Theme.of(context).columnSize * 7,
                  ),
                  child: const CircularProgressIndicator(),
                );
        },
      ),
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

  void bookCarona(int caronaID) async {
    await _service!.bookCarona(caronaID);
    if (!mounted) return;

    if (_service!.state == NotifierState.loaded) {
      showSnackBar(context, const CustomSnackBar.success(message: 'Carona reservada com sucesso'));
      Navigator.pushReplacementNamed(context, tabsPage);
    } else if (_service!.state == NotifierState.failure) {
      showSnackBar(context, CustomSnackBar.error(message: _service!.failure!.message));
    }
  }
}
