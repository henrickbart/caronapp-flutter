import 'locationResponse.model.dart';

///Classe que guarda dados da resposta da requisição de consulta de localizações
class LocationListResponse {
  List<LocationResponse>? locations;

  LocationListResponse({
    required locations,
  });

  LocationListResponse.fromJson(Map<String, dynamic> json)
      : locations = json['locations'] != null && List.from(json['locations']).isNotEmpty ? List<LocationResponse>.from(json['locations'].map((e) => LocationResponse.fromJson(e))) : List.empty();
}
