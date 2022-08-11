import 'caronaResponse.model.dart';

///Classe que guarda dados da resposta da requisição de consulta de caronas
class CaronaListResponse {
  List<CaronaResponse>? caronas;

  CaronaListResponse({
    required caronas,
  });

  CaronaListResponse.fromJson(Map<String, dynamic> json) : caronas = json['caronas'] != null && List.from(json['caronas']).isNotEmpty ? List<CaronaResponse>.from(json['caronas'].map((e) => CaronaResponse.fromJson(e))) : List.empty();
}
