import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:dio/dio.dart';
import '../model/response/groupResponse.model.dart';
import 'base.repository.dart';

class LocationRepository extends BaseRepository {
  static Dio dio = Dio();

  ///Inicializa as configurações do Dio
  LocationRepository() {
    configureDio(dio);
  }

  ///Método que retorna os locais cadastrados para carona
  Future<List<LocationResponse>> getLocations(String query) async {
    Response response = await dio.get('${BaseRepository.serverURL}/getLocalizacao/$query', options: Options(headers: {'requiresToken': true}));

    // var data = [
    //   {"id": 1, "local": "BNH", "cidade_estado": "Cachoeiro de Itapemirim, Espírito Santo"},
    //   {"id": 2, "local": "Centro", "cidade_estado": "Ipatinga, Minas Gerais"},
    //   {"id": 3, "local": "Centro", "cidade_estado": "Ipatinga, Minas Gerais"},
    //   {
    //     "id": 4,
    //     "local": "Lugar com nome muito grande pra cacete para eu poder testar se está cortando ou dando erro na paradinha",
    //     "cidade_estado": "Lugar com nome muito grande pra cacete para eu poder testar se está cortando ou dando erro na paradinha"
    //   }
    // ];

    // if (query.isEmpty) {
    //   data = [];
    // }

    return (response.data as List).map((x) => LocationResponse.fromJson(x)).toList();
  }
}
