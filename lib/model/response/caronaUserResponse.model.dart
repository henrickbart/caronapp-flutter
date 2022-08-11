///Classe que guarda dados da resposta da requisição de carona do usuario
class CaronaUserResponse {
  int id;
  DateTime date;
  double price;
  String source;
  String destination;

  CaronaUserResponse({
    required this.id,
    required this.date,
    required this.price,
    required this.source,
    required this.destination,
  });

  CaronaUserResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        price = json['price'],
        source = json['source'],
        destination = json['destination'];
}
