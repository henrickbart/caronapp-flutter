import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';

import '../model/viewModel/failure.model.dart';
import '../service/base.service.dart';
import 'customNotificationState.widget.dart';

///Classe responsável por auxiliar o carregamento de uma lista, de acordo com o estado dos dados da mesma
class CustomListLoader extends StatelessWidget {
  final NotifierState notifierState;
  final bool emptyList;
  final Function buildLoadedList;
  final Function buildLoadingList;
  final CustomNotificationState emptyState;
  final CustomNotificationState failureState;
  final Failure? failure;

  CustomListLoader({required this.notifierState, required this.emptyList, required this.buildLoadedList, required this.buildLoadingList, required this.emptyState, required this.failureState, this.failure});

  @override
  Widget build(BuildContext context) {
    if (notifierState == NotifierState.loaded || (failure != null && failure!.statusCode == 400)) {
      return emptyList ? Container(height: Theme.of(context).maxHeight, child: emptyState) : buildLoadedList();
    } else if (notifierState == NotifierState.loading) {
      return buildLoadingList();
    } else if (notifierState == NotifierState.failure) {
      return Container(height: Theme.of(context).maxHeight, child: failureState);
    }

    return Center(child: Text('Estado inesperado: $notifierState'));
  }
}
