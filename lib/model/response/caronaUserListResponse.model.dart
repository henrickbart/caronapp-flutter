import 'caronaUserResponse.model.dart';

///Classe que guarda dados da resposta da requisição de consulta de caronas do usuario
class CaronaUserListResponse {
  List<CaronaUserResponse>? caronas;

  CaronaUserListResponse({
    required caronas,
  });

  CaronaUserListResponse.fromJson(Map<String, dynamic> json)
      : caronas = json['caronas'] != null && List.from(json['caronas']).isNotEmpty ? List<CaronaUserResponse>.from(json['caronas'].map((e) => CaronaUserResponse.fromJson(e))) : List.empty();
}
