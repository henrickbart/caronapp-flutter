///Objeto com os dados necessarios para realizar a avaliação de um usuário
class CaronaUserReviewRequest {
  int userID;
  int caronaID;
  double score;
  String? notes;

  CaronaUserReviewRequest({
    required this.userID,
    required this.caronaID,
    required this.score,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userID'] = userID;
    data['caronaID'] = caronaID;
    data['score'] = score;
    data['notes'] = notes ?? "";

    return data;
  }
}
