import 'dart:typed_data';

import '../../util/formaters.util.dart';

///Classe que guarda dados da resposta da requisição dos dados de um veículo
class UserVehicleResponse {
  int id;
  String brand;
  String model;
  Uint8List? photo;
  String year;
  String color;
  int seats;
  String plate;
  String? renavam;

  UserVehicleResponse({
    required this.id,
    required this.brand,
    required this.model,
    this.photo,
    required this.year,
    required this.color,
    required this.seats,
    required this.plate,
    this.renavam,
  });

  UserVehicleResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['marca'],
        model = json['modelo'],
        photo = json['foto'] != null ? Formaters.dataFromBase64String(json['foto']) : null,
        year = json['ano'],
        color = json['cor'],
        seats = json['espaco'],
        plate = json['placa'],
        renavam = json['renavam'] ?? "";
}
