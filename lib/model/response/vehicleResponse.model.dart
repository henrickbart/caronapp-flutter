import 'dart:typed_data';

import '../../util/formaters.util.dart';

///Classe que guarda dados da resposta da requisição dos dados de um veículo
class VehicleResponse {
  int id;
  String brand;
  String model;
  Uint8List? photo;
  String type;
  int seats;

  VehicleResponse({
    required this.id,
    required this.brand,
    required this.model,
    this.photo,
    required this.type,
    required this.seats,
  });

  VehicleResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['marca'],
        model = json['nome'],
        photo = json['foto'] != null ? Formaters.dataFromBase64String(json['foto']) : null,
        type = json['tipo'],
        seats = json['capacidade'];
}
