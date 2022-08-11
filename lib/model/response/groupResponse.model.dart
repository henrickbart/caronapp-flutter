///Classe que guarda dados da resposta da requisição da consulta de grupo
class GroupResponse {
  int id;
  String name;
  String shareCode;

  GroupResponse({required this.id, required this.name, required this.shareCode});

  GroupResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['nome'],
        shareCode = json['codigo'];
}
