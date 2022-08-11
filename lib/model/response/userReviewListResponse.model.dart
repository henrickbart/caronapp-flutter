import 'package:caronapp/model/response/groupResponse.model.dart';
import 'package:caronapp/model/response/userReviewResponse.model.dart';

///Classe que guarda dados da resposta da requisição de consulta de avaliações de um usuário
class UserReviewListResponse {
  List<UserReviewResponse>? reviews;

  UserReviewListResponse({
    required reviews,
  });

  UserReviewListResponse.fromJson(Map<String, dynamic> json)
      : reviews = json['reviews'] != null && List.from(json['reviews']).isNotEmpty ? List<UserReviewResponse>.from(json['reviews'].map((e) => UserReviewResponse.fromJson(e))) : List.empty();
}
