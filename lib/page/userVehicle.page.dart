import 'package:caronapp/model/response/userVehicleResponse.model.dart';
import 'package:caronapp/service/account.service.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customListLoader.widget.dart';
import 'package:caronapp/widget/customNotificationState.widget.dart';
import 'package:caronapp/widget/customVehicleItem.widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../widget/customAppBar.widget.dart';
import '../widget/customSnackBar.widget.dart';
import 'base.page.dart';

class UserVehiclePage extends StatefulWidget {
  UserVehiclePage({Key? key}) : super(key: key);

  @override
  State<UserVehiclePage> createState() => _UserVehiclePageState();
}

class _UserVehiclePageState extends State<UserVehiclePage> {
  AccountService? _service;

  List<UserVehicleResponse> _vehicles = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      _service = Provider.of<AccountService>(context);
      loadList(false);
    }

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Cadastro de veículo',
      ),
      floatingActionButton: Visibility(
        visible: _service!.state == NotifierState.loaded,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, userVehicleAddPage).then((value) => loadList()),
        ),
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
            emptyList: _vehicles.isEmpty,
            emptyState: buildEmptyState(),
            failureState: buildFailureState(),
          ),
        ),
      ),
    );
  }

  //Função para carregar a lista de caronas da API
  Future<void> loadList([bool notifyListener = true]) async {
    _vehicles = await _service!.getUserVehicles(notifyListener);
  }

  ///Método para renderizar o widget de empty state
  CustomNotificationState buildEmptyState() {
    return const CustomNotificationState(
      asset: 'assets/empty_state_vehicle.svg',
      assetSize: 8,
      title: 'Você não possui nenhum veículo cadastrado',
      subtitle: 'Cadastre um veículo clicando no "+" abaixo',
      useHorizontalPadding: true,
    );
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
      itemCount: _vehicles.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CustomVehicleItem(
              model: _vehicles[index],
              onTap: () => showConfirmationDialog(context, index),
            ),
          ],
        );
      },
    );
  }

  showConfirmationDialog(BuildContext context, int index) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Exluir o veículo'),
        content: const Text('Tem certeza que deseja excluir o veículo?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('CANCELAR', style: TextStyle(fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily, color: Theme.of(context).colorScheme.disabled))),
          TextButton(
              onPressed: () async {
                await _service!.deleteUserVehicle(_vehicles[index].id);
                if (!mounted) return;

                if (_service!.state == NotifierState.loaded) {
                  showSnackBar(context, const CustomSnackBar.success(message: 'Veículo excluído com sucesso'));
                  loadList();
                  Navigator.pop(ctx);
                } else if (_service!.state == NotifierState.failure) {
                  showSnackBar(context, CustomSnackBar.error(message: _service!.failure!.message));
                }
              },
              child: Text('CONFIRMAR', style: TextStyle(fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily, color: Theme.of(context).colorScheme.primary))),
        ],
      ),
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
          children: [
            CustomVehicleItem.loading(),
            SizedBox(height: Theme.of(context).rowSize / 2),
          ],
        );
      },
    );
  }
}
