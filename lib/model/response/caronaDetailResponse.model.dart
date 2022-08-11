import 'package:caronapp/model/response/userResponse.model.dart';
import 'package:caronapp/model/response/userVehicleResponse.model.dart';

///Classe que guarda dados da resposta da requisição de carona
class CaronaDetailResponse {
  int id;
  DateTime date;
  double price;
  DateTime start;
  DateTime end;
  String source;
  String destination;
  String avaiableSeats;
  String? notes;
  UserResponse driver;
  List<UserResponse>? passengers;
  UserVehicleResponse vehicle;

  CaronaDetailResponse(
      {required this.id,
      required this.date,
      required this.price,
      required this.start,
      required this.end,
      required this.source,
      required this.destination,
      required this.avaiableSeats,
      this.notes,
      required this.driver,
      this.passengers,
      required this.vehicle});

  CaronaDetailResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        price = json['price'],
        start = DateTime.parse(json['start']),
        end = DateTime.parse(json['end']),
        source = json['source'],
        destination = json['destination'],
        avaiableSeats = json['avaiableSeats'],
        notes = json['notes'] ?? "",
        driver = UserResponse.fromJson(json['driver']),
        passengers = json['passengers'] != null && List.from(json['passengers']).isNotEmpty ? List<UserResponse>.from(json['passengers'].map((e) => UserResponse.fromJson(e))) : List.empty(),
        vehicle = UserVehicleResponse.fromJson(json['vehicle']);
}
