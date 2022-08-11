import 'package:caronapp/model/request/loginRequest.model.dart';
import 'package:caronapp/model/request/userVehicleAddRequest.model.dart';
import 'package:caronapp/model/response/userVehicleResponse.model.dart';
import 'package:caronapp/util/authorization.util.dart';
import '../model/request/signupRequest.model.dart';
import '../model/response/vehicleResponse.model.dart';
import '../repository/account.repository.dart';
import 'base.service.dart';

class AccountService extends BaseService {
  final _repository = AccountRepository();

  ///Método para realizar o login do usuário no repositório
  Future<void> login(String user, String password) async {
    try {
      setState(NotifierState.loading);

      var response = await _repository.login(LoginRequest(user: user, password: password));
      Authorization.info = response;

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  ///Método para realizar o cadastro do usuário no repositório
  Future<void> signup(String name, String email, String cpf, String phone, String password) async {
    try {
      setState(NotifierState.loading);

      await _repository.signup(SignupRequest(name: name, email: email, cpf: cpf, phone: phone, password: password));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  ///Método para realizar o envio da documentação do usuário no repositório
  Future<void> sendDocument(String document) async {
    try {
      setState(NotifierState.loading);

      await Future.delayed(const Duration(seconds: 2));

      //await _repository.signup(SignupRequest(name: name, email: email, cpf: cpf, phone: phone, password: password, confirmation: confirmation));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  ///Método para buscar os veículos cadastrados no repositório
  Future<List<VehicleResponse>> getVehicles([bool notifyListener = true]) async {
    List<VehicleResponse> vehicles = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      vehicles = await _repository.getVehicles();
      await Future.delayed(const Duration(seconds: 3));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return vehicles;
  }

  ///Método para buscar os veículos do usuário no repositório
  Future<List<UserVehicleResponse>> getUserVehicles([bool notifyListener = true]) async {
    List<UserVehicleResponse> userVehicles = List.empty(growable: true);

    try {
      setState(NotifierState.loading, notifyListener);

      userVehicles = await _repository.getUserVehicles();
      //await Future.delayed(const Duration(seconds: 3));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }

    return userVehicles;
  }

  ///Método para realizar o cadastro do veículo do usuário no repositório
  Future<void> addUserVehicle(int vehicleID, String color, int year, String plate, String renavam) async {
    try {
      setState(NotifierState.loading);

      await _repository.addUserVehicle(UserVehicleAddRequest(vehicleID: vehicleID, year: year, color: color, plate: plate, renavam: renavam));

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }

  ///Método para deleter um veículo do usuário no repositório
  Future<void> deleteUserVehicle(int userVehicleID) async {
    try {
      setState(NotifierState.loading);

      await _repository.deleteUserVehicle(userVehicleID);

      setState(NotifierState.loaded);
    } catch (error) {
      checkError(error);
    }
  }
}
