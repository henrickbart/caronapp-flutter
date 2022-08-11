///Objeto com os dados necessarios para realizar o cadastro na aplicação
class SignupRequest {
  String cpf;
  String name;
  String email;
  String phone;
  String password;

  SignupRequest({
    required this.cpf,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cpf'] = cpf;
    data['nome'] = name;
    data['email'] = email;
    data['telefone'] = phone;
    data['senha'] = password;

    return data;
  }
}
