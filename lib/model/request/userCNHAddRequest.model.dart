///Objeto com os dados necessarios para realizar o cadastro de uma CNH
class UserCNHAddRequest {
  String userID;
  String cnh;

  UserCNHAddRequest({
    required this.userID,
    required this.cnh,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userID'] = userID;
    data['cnh'] = cnh;

    return data;
  }
}
