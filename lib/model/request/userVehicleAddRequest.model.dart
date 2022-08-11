///Objeto com os dados necessarios para realizar o cadastro de um veículo
class UserVehicleAddRequest {
  int vehicleID;
  int year;
  String color;
  String plate;
  String renavam;

  UserVehicleAddRequest({
    required this.vehicleID,
    required this.year,
    required this.color,
    required this.plate,
    required this.renavam,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['veiculo_id'] = vehicleID;
    data['ano'] = year;
    data['cor'] = color;
    data['placa'] = plate;
    data['renavam'] = renavam;

    return data;
  }
}
