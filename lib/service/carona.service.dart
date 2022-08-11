import 'package:caronapp/model/request/caronaAddRequest.model.dart';
import 'package:caronapp/model/request/caronaSearchRequest.model.dart';
import 'package:caronapp/model/response/caronaResponse.model.dart';

import '../repository/carona.repository.dart';
import 'base.service.dart';

class CaronaService extends BaseService {
  final _repository = CaronaRepository();

  //Método para consultar as caronas no repositório
  Future<List<CaronaResponse>> getCaronas([bool notifyListener = true]) async {
    List<CaronaResponse> caronas = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      caronas = await _repository.getCaronas();
      caronas.sort(((a, b) => a.compareTo(b)));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return caronas;
  }

  //Método para adicionar uma carona no repositório
  Future<void> addCarona(int originID, int destinationID, int vehicleUserID, DateTime date, int avaiableSeats, double price, [int? groupID]) async {
    try {
      setState(NotifierState.loading);

      await _repository.addCarona(CaronaAddRequest(originID: originID, destinationID: destinationID, vehicleUserID: vehicleUserID, date: date, avaiableSeats: avaiableSeats, price: price, groupID: groupID));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  //Método para reservar uma carona no repositório
  Future<void> bookCarona(int caronaID) async {
    try {
      setState(NotifierState.loading);

      await _repository.bookCarona(caronaID);

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  //Método para buscar uma lista de caronas no repositório com base no filtro
  Future<List<CaronaResponse>> searchCaronas(int originID, int destinationID, DateTime date, [bool notifyListener = true]) async {
    List<CaronaResponse> caronas = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      //Aguardando tempo para exibir a animação
      await Future.delayed(const Duration(seconds: 4));

      caronas = await _repository.searchCaronas(CaronaSearchRequest(originID: originID, destinationID: destinationID, date: date));
      caronas.sort(((a, b) => a.compareTo(b)));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return caronas;
  }

  //Método para buscar uma lista de caronas no repositório com base no filtro
  Future<List<CaronaResponse>> searchCaronasByGroup(int groupID, [bool notifyListener = true]) async {
    List<CaronaResponse> caronas = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      //Aguardando tempo para exibir a animação
      await Future.delayed(const Duration(seconds: 4));

      caronas = await _repository.searchCaronasByGroup(groupID);
      caronas.sort(((a, b) => a.compareTo(b)));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return caronas;
  }
}
