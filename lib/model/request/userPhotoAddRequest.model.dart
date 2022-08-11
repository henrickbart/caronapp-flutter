///Objeto com os dados necessarios para realizar o cadastro de uma foto para o usuário
class UserPhotoAddRequest {
  String userID;
  String photo;

  UserPhotoAddRequest({
    required this.userID,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userID'] = userID;
    data['photo'] = photo;

    return data;
  }
}
