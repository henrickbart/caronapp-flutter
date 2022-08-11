///Classe que guarda dados da resposta da requisição de login
class LoginResponse {
  int id;
  String name;
  String email;
  String? photo;
  String token;

  LoginResponse({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
    required this.token,
  });

  LoginResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['nome'],
        email = json['email'],
        photo = json['photo'] ?? "",
        token = json['token'];
}
