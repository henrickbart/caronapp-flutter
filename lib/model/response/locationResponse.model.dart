///Classe que guarda dados da resposta da requisição de localização
class LocationResponse {
  int? id;
  String name;
  String cityState;

  LocationResponse({
    required id,
    required this.name,
    required this.cityState,
  });

  LocationResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['local'],
        cityState = json['cidade_estado'];
}
