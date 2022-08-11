import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/service/carona.service.dart';
import 'package:caronapp/service/location.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customListLoader.widget.dart';
import 'package:caronapp/widget/customLocationItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../widget/customAppBar.widget.dart';
import '../widget/customNotificationState.widget.dart';
import '../widget/customTextFormField.widget.dart';
import 'base.page.dart';

class LocationPage extends StatefulWidget {
  LocationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationService? _service;
  List<LocationResponse> _locations = List.empty(growable: true);
  final _ctrlFilter = TextEditingController();

  @override
  void dispose() {
    _ctrlFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service ??= Provider.of<LocationService>(context);
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Selecionar localização'),
      body: BasePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Theme.of(context).rowSize,
                horizontal: Theme.of(context).columnSize,
              ),
              child: CustomTextFormField(
                  hint: 'Insira a chave de pesquisa',
                  keyboardType: TextInputType.text,
                  controller: _ctrlFilter,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  prefixIcon: Icons.search,
                  suffixIcon: _ctrlFilter.text.isNotEmpty ? Icons.close : null,
                  suffixIconOnTap: () {
                    setState(() {
                      _ctrlFilter.clear();
                      loadList();
                    });
                  },
                  onChanged: (String string) {
                    loadList();
                  }),
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
                  emptyList: _locations.isEmpty,
                  buildLoadedList: () => buildLoadedList(context),
                  buildLoadingList: () => buildLoadingList(context),
                  emptyState: buildEmptyState(),
                  failureState: buildFailureState(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Função para carregar a lista de carros da API
  Future<void> loadList([bool notifyListener = true]) async {
    if (_service!.state != NotifierState.loading) {
      _locations = await _service!.getLocations(_ctrlFilter.text, notifyListener);
    }
  }

  ///Método para renderizar o widget de empty state
  CustomNotificationState buildEmptyState() {
    return const CustomNotificationState(
      asset: 'assets/empty_state_location.svg',
      assetSize: 8,
      title: 'Nenhuma localização encontrada',
      subtitle: 'Tente alterar a chave de pesquisa',
      useHorizontalPadding: true,
    );
  }

  ///Método para renderizar o widget de erro
  CustomNotificationState buildFailureState() {
    return const CustomNotificationState.failure(
      useHorizontalPadding: true,
    );
  }

  ///Método para renderizar a lista após a tela ser carregada
  Widget buildLoadedList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: _locations.length,
      itemBuilder: (context, index) {
        return CustomLocationItem(
          model: _locations[index],
          onTap: () {
            Navigator.pop(context, _locations[index]);
          },
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
        return CustomLocationItem.loading();
      },
    );
  }
}
