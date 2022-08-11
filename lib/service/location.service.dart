import 'package:caronapp/repository/locationRepository.dart';

import '../model/response/locationResponse.model.dart';
import 'base.service.dart';

class LocationService extends BaseService {
  final _repository = LocationRepository();

  LocationService() {
    setState(NotifierState.loaded, false);
  }

//Método para consultar as localizações no repositório
  Future<List<LocationResponse>> getLocations(String query, [bool notifyListener = true]) async {
    List<LocationResponse> locations = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      //Aguardando tempo para não fazer muitas consultas no repositório
      await Future.delayed(const Duration(milliseconds: 25));

      locations = await _repository.getLocations(query);
      locations.sort(((a, b) => a.name.compareTo(b.name)));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return locations;
  }
}
