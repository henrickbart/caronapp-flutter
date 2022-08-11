import 'package:caronapp/model/response/locationResponse.model.dart';

import 'driverResponse.model.dart';

///Classe que guarda dados da resposta da requisição de carona
class CaronaResponse implements Comparable<CaronaResponse> {
  int id;
  DateTime date;
  DateTime? beginDate;
  DateTime? endDate;
  double price;
  LocationResponse origin;
  LocationResponse destination;
  int avaiableSeats;
  DriverResponse driver;

  CaronaResponse({
    required this.id,
    required this.date,
    this.beginDate,
    this.endDate,
    required this.price,
    required this.origin,
    required this.destination,
    required this.avaiableSeats,
    required this.driver,
  });

  CaronaResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['data']),
        beginDate = json['datainicio'] != null ? DateTime.parse(json['datainicio']) : null,
        endDate = json['datafim'] != null ? DateTime.parse(json['datafim']) : null,
        price = double.parse(json['valor'].toString()),
        origin = LocationResponse.fromJson(json['origem']),
        destination = LocationResponse.fromJson(json['destino']),
        avaiableSeats = json['espaco'],
        driver = DriverResponse.fromJson(json['condutor']);

  @override
  int compareTo(CaronaResponse other) {
    if (beginDate != null && endDate == null) {
      return -1;
    } else if (beginDate != null && endDate != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
