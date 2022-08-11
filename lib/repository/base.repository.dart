// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:dio/dio.dart';

import '../util/authorization.util.dart';

///Classe base que configura o client http
class BaseRepository {
  static String serverURL = 'https://8c84-177-158-49-240.sa.ngrok.io/api';

  ///Metodo para adicionar interceptores no objeto Dio.
  void configureDio(Dio dio) {
    dio.options.connectTimeout = 10000; //10 segundos
    dio.options.sendTimeout = 10000; //10 segundos
    dio.options.receiveTimeout = 10000; //10 segundos

    dio
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) => _requestInterceptor(options, handler),
        onError: (DioError error, ErrorInterceptorHandler handler) => _errorInterceptor(dio, error, handler),
      ));
  }

  ///Método que configura o interceptor OnRequest
  dynamic _requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('requiresToken')) {
      options.headers.remove('requiresToken');
      if (Authorization.info?.token == null) {
        throw Exception("Não foi possível encontrar o token para autorização no servidor.");
      }

      //Buscando token na memoria
      String token = Authorization.info!.token;

      //Adicionando o cabeçalho 'Authorization'
      options.headers.addAll({"Authorization": "Bearer $token"});
    }

    return handler.next(options);
  }

  ///Método que configura o interceptor "onError".
  dynamic _errorInterceptor(Dio dio, DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      throw Exception("O servidor informou que o cliente não está autorizado.");
    }

    return handler.next(error);
  }
}
