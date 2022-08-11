///Classe que guarda dados da resposta da requisição de consulta de avaliações do usuário
class UserReviewResponse {
  String name;
  String? photo;
  double score;
  String? notes;

  UserReviewResponse({
    required this.name,
    this.photo,
    required this.score,
    this.notes,
  });

  UserReviewResponse.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        photo = json['photo'] ?? "",
        score = json['score'],
        notes = json['notes'] ?? "";
}
