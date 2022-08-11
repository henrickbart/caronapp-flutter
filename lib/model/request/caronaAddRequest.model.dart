///Objeto com os dados necessarios para adicionar uma carona
class CaronaAddRequest {
  int originID;
  int destinationID;
  int vehicleUserID;
  int? groupID;
  DateTime date;
  int avaiableSeats;
  double price;
  String? notes;

  CaronaAddRequest({
    required this.originID,
    required this.destinationID,
    required this.vehicleUserID,
    this.groupID,
    required this.date,
    required this.avaiableSeats,
    required this.price,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['origem'] = originID;
    data['destino'] = destinationID;
    data['veiculo'] = vehicleUserID;
    if (groupID != null) {
      data['grupo'] = groupID;
    }
    data['data'] = date.toIso8601String();
    data['espaco'] = avaiableSeats;
    data['valor'] = price;
    data['notes'] = notes ?? "";

    return data;
  }
}
