///Classe que guarda dados da resposta da requisição dos dados de um usuário
class UserResponse {
  int id;
  String name;
  String? photo;
  double score;
  int reviews;
  String? cnh;

  UserResponse({required this.id, required this.name, this.photo, required this.score, required this.reviews, this.cnh});

  UserResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        photo = json['photo'] ?? "",
        score = json['score'],
        reviews = json['reviews'],
        cnh = json['cnh'] ?? "";
}
