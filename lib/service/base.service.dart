import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../model/viewModel/failure.model.dart';

enum NotifierState { initial, loading, loaded, failure }

///Classe base que disponibiliza abstrações de estado e falha das requisições
class BaseService extends ChangeNotifier {
  ///Estado do provider
  NotifierState _state = NotifierState.initial;

  ///Propiedade para obter o estado do provider
  NotifierState get state => _state;

  ///Metodo para definir o estado do provider
  void setState(NotifierState state, [bool notifyListener = true]) {
    _state = state;
    _failure = null;
    if (notifyListener) notifyListeners();
  }

  ///Falha do provider
  late Failure? _failure;

  ///Propiedade para obter a falha do provider
  Failure? get failure => _failure;

  ///Metodo para definir a falha do provider
  void setFailure(Failure failure, [bool notifyListener = true]) {
    setState(NotifierState.failure, notifyListener);
    _failure = failure;
    if (notifyListener) notifyListeners();
  }

  ///Metodo que checa os erros de conexão e os erros retornados pela API
  void checkError(error, [bool notifyListener = true]) {
    if (error is DioError && error.response != null && error.response!.statusCode == 400) {
      var err = error.response!.data;
      setFailure(Failure(message: err['error'] ?? "Um erro não esperado aconteceu no servidor", statusCode: error.response!.statusCode!), notifyListener);
    } else if (error is DioError && error.response != null && error.response!.statusCode == 404) {
      setFailure(
        Failure(
          message: "Ponto de extremidade não encontrado.",
          statusCode: error.response!.statusCode!,
        ),
        notifyListener,
      );
    } else if (error is DioError && error.type == DioErrorType.other) {
      setFailure(
        Failure(
          message: "Servidor não encontrado",
          statusCode: 400,
        ),
        notifyListener,
      );
    } else if (error is DioError && error.error is SocketException) {
      setFailure(
        Failure(
          message: 'Não foi possivel acessar o servidor. Por favor, verifique sua conexão de rede',
          statusCode: 500,
        ),
        notifyListener,
      );
    } else if (error is DioError && error.type == DioErrorType.connectTimeout) {
      setFailure(
        Failure(
          message: 'Não foi possivel acessar o servidor.',
          statusCode: 500,
        ),
        notifyListener,
      );
    } else if (error is DioError && error.type == DioErrorType.receiveTimeout) {
      setFailure(
        Failure(
          message: 'Não foi possivel acessar o servidor.',
          statusCode: 500,
        ),
        notifyListener,
      );
    } else if (error is DioError && error.type == DioErrorType.sendTimeout) {
      setFailure(
        Failure(
          message: 'Não foi possivel acessar o servidor.',
          statusCode: 500,
        ),
        notifyListener,
      );
    } else {
      setFailure(
        Failure(
          message: "Um erro não esperado aconteceu:\n${error.toString()}",
          statusCode: 500,
        ),
        notifyListener,
      );
    }
  }
}
