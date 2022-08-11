import 'package:caronapp/model/response/groupResponse.model.dart';

import '../repository/group.repository.dart';
import 'base.service.dart';

class GroupService extends BaseService {
  final _repository = GroupRepository();

  //Método para consultar os grupos do usuário no repositório
  Future<List<GroupResponse>> getUserGroups([bool notifyListener = true]) async {
    List<GroupResponse> groups = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      groups = await _repository.getUserGroups();

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return groups;
  }

  //Método para criar um grupo no repositório
  Future<void> addGroup(String groupName) async {
    try {
      setState(NotifierState.loading);

      await _repository.addGroup(groupName);

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  //Método para entrar em um grupo através do código no repositório
  Future<void> addGroupByCode(String groupCode) async {
    try {
      setState(NotifierState.loading);

      await _repository.addGroupByCode(groupCode);

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }
}
