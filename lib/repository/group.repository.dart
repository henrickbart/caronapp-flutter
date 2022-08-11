import 'package:caronapp/util/authorization.util.dart';
import 'package:dio/dio.dart';
import '../model/response/groupResponse.model.dart';
import 'base.repository.dart';

class GroupRepository extends BaseRepository {
  static Dio dio = Dio();

  ///Inicializa as configurações do Dio
  GroupRepository() {
    configureDio(dio);
  }

  ///Método que retorna os grupos do usuario
  Future<List<GroupResponse>> getUserGroups() async {
    Response response = await dio.get('${BaseRepository.serverURL}/getGruposUsuario', options: Options(headers: {'requiresToken': true}));
    return (response.data as List).map((x) => GroupResponse.fromJson(x)).toList();

    // List<GroupResponse> lista = List.empty(growable: true);
    // lista.add(GroupResponse(id: 1, name: "CCOMP UFES"));
    // lista.add(GroupResponse(id: 2, name: "Amigos do Rogerinho"));
    // lista.add(GroupResponse(id: 3, name: "Vitória x Vila Velha"));

    // return lista;
  }

  ///Método para adicionar um grupo
  Future<void> addGroup(String groupName) async => await dio.post('${BaseRepository.serverURL}/addGrupo/$groupName', options: Options(headers: {'requiresToken': true}));

  ///Método para entrar em um grupo através do código
  Future<void> addGroupByCode(String groupCode) async => await dio.post('${BaseRepository.serverURL}/addGrupoByCodigo/$groupCode', options: Options(headers: {'requiresToken': true}));
}
