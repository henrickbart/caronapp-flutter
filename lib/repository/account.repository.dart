import 'package:caronapp/model/request/loginRequest.model.dart';
import 'package:caronapp/model/request/userVehicleAddRequest.model.dart';
import 'package:caronapp/model/response/loginResponse.model.dart';
import 'package:caronapp/model/response/userVehicleResponse.model.dart';
import 'package:dio/dio.dart';
import '../model/request/signupRequest.model.dart';
import '../model/response/vehicleResponse.model.dart';
import 'base.repository.dart';

class AccountRepository extends BaseRepository {
  static Dio dio = Dio();

  ///Inicializa as configurações do Dio
  AccountRepository() {
    configureDio(dio);
  }

  ///Método para realizar o login do usuário
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var response = await dio.post('${BaseRepository.serverURL}/login', data: loginRequest);
    return LoginResponse.fromJson(response.data);

    //return LoginResponse(id: 1, name: "Henrick", email: "email", token: "token");
  }

  ///Método para realizar o cadastro do usuário
  Future<void> signup(SignupRequest signupRequest) async => await dio.post('${BaseRepository.serverURL}/signup', data: signupRequest);

  ///Método que retorna os veículos
  Future<List<VehicleResponse>> getVehicles() async {
    Response response = await dio.get('${BaseRepository.serverURL}/getVeiculos', options: Options(headers: {'requiresToken': true}));
    return (response.data as List).map((x) => VehicleResponse.fromJson(x)).toList();

    // List<VehicleResponse> vehicles = List.empty(growable: true);
    // vehicles.add(VehicleResponse(id: 1, brand: "Chevrolet", model: "Celta", type: "CARRO", seats: 5));
    // vehicles.add(VehicleResponse(id: 2, brand: "Hyundai", model: "HB20", type: "CARRO", seats: 5));

    //return vehicles;
  }

  ///Método que retorna os veículos do usuario
  Future<List<UserVehicleResponse>> getUserVehicles() async {
    Response response = await dio.get('${BaseRepository.serverURL}/getVeiculosUsuario', options: Options(headers: {'requiresToken': true}));
    return (response.data as List).map((x) => UserVehicleResponse.fromJson(x)).toList();

    // List<UserVehicleResponse> vehicles = List.empty(growable: true);
    // vehicles.add(UserVehicleResponse(id: 1, brand: "Chevrolet", model: "Celta", year: "2012", color: "Preto", seats: 5, plate: "RBH5J24", renavam: "27972687876"));
    // vehicles.add(UserVehicleResponse(id: 2, brand: "Hyundai", model: "HB20", year: "2020", color: "Prata", seats: 5, plate: "QRE2H12", renavam: "88518367120"));

    // return vehicles;
  }

  ///Método para adicionar um veículo para o usuário
  Future<void> addUserVehicle(UserVehicleAddRequest userVehicleAddRequest) async => await dio.post('${BaseRepository.serverURL}/addVeiculoUsuario', data: userVehicleAddRequest, options: Options(headers: {'requiresToken': true}));

  ///Método para deletar um veículo do usuário
  Future<void> deleteUserVehicle(int userVehicleId) async => await dio.delete('${BaseRepository.serverURL}/deleteVeiculoUsuario/$userVehicleId', options: Options(headers: {'requiresToken': true}));
}
