import 'package:caronapp/model/response/userVehicleResponse.model.dart';

///Classe que guarda dados da resposta da requisição de consulta de veículos de um usuário
class UserVehicleListResponse {
  List<UserVehicleResponse>? vehicles;

  UserVehicleListResponse({
    required vehicles,
  });

  UserVehicleListResponse.fromJson(Map<String, dynamic> json)
      : vehicles = json['vehicles'] != null && List.from(json['vehicles']).isNotEmpty ? List<UserVehicleResponse>.from(json['vehicles'].map((e) => UserVehicleResponse.fromJson(e))) : List.empty();
}
