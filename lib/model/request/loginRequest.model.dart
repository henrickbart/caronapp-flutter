///Objeto com os dados necessarios para realizar login na aplicação
class LoginRequest {
  String user;
  String password;

  LoginRequest({
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = user;
    data['senha'] = password;

    return data;
  }
}
