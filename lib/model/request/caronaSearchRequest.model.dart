///Objeto com os dados necessarios para consultar as caronas disponíveis
class CaronaSearchRequest {
  int originID;
  int destinationID;
  DateTime date;

  CaronaSearchRequest({
    required this.originID,
    required this.destinationID,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['origem'] = originID;
    data['destino'] = destinationID;
    data['data'] = date.toIso8601String();

    return data;
  }
}
