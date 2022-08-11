///Classe que guarda dados da resposta da requisição da consulta do condutor
class DriverResponse {
  String name;
  String vehicle;
  String? photo;

  DriverResponse({required this.name, required this.vehicle, this.photo});

  DriverResponse.fromJson(Map<String, dynamic> json)
      : name = json['nome'],
        vehicle = json['veiculo'],
        photo = json['foto'];
}
