import 'package:caronapp/model/request/caronaAddRequest.model.dart';
import 'package:caronapp/model/request/caronaSearchRequest.model.dart';
import 'package:caronapp/model/response/caronaResponse.model.dart';
import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/util/authorization.util.dart';
import 'package:dio/dio.dart';
import 'base.repository.dart';

class CaronaRepository extends BaseRepository {
  static Dio dio = Dio();

  ///Inicializa as configurações do Dio
  CaronaRepository() {
    configureDio(dio);
  }

  ///Método que retorna as caronas do usuario
  Future<List<CaronaResponse>> getCaronas() async {
    Response response = await dio.get('${BaseRepository.serverURL}/getCaronasByUsuario', options: Options(headers: {'requiresToken': true}));

    return (response.data as List).map((x) => CaronaResponse.fromJson(x)).toList();
  }

  ///Método para adicionar uma carona
  Future<void> addCarona(CaronaAddRequest caronaAddRequest) async => await dio.post('${BaseRepository.serverURL}/addCarona', data: caronaAddRequest, options: Options(headers: {'requiresToken': true}));

  ///Método para reservar uma carona
  Future<void> bookCarona(int caronaID) async => await dio.post('${BaseRepository.serverURL}/reservarCarona/$caronaID', options: Options(headers: {'requiresToken': true}));

  ///Método para retornar uma lista de caronas com base no filtro
  Future<List<CaronaResponse>> searchCaronas(CaronaSearchRequest caronaSearchRequest) async {
    Response response = await dio.post('${BaseRepository.serverURL}/getCaronas', data: caronaSearchRequest, options: Options(headers: {'requiresToken': true}));
    return (response.data as List).map((x) => CaronaResponse.fromJson(x)).toList();
  }

  ///Método para retornar uma lista de caronas de um grupo
  Future<List<CaronaResponse>> searchCaronasByGroup(int groupID) async {
    Response response = await dio.get('${BaseRepository.serverURL}/getCaronasByGrupo/$groupID', options: Options(headers: {'requiresToken': true}));
    return (response.data as List).map((x) => CaronaResponse.fromJson(x)).toList();
  }
}
