import 'dart:typed_data';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

///Classe usada para formatar valores da aplicação
class Formaters {
  ///Método para formatar milisegundos from epoch em data
  static DateTime epochToDate(int millisecondsEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsEpoch);
  }

  ///Método para formatar a data para dia/mes/ano
  static String dateTimeToDate(DateTime dateTime) {
    initializeDateFormatting('pt_BR', null);
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }

  ///Método para formatar a data para data completa e hora
  static String dateTimeToDateAndTime(DateTime dateTime) {
    initializeDateFormatting('pt_BR', null);
    return "${DateFormat('dd/MM/yyyy').format(dateTime)}, às ${DateFormat('HH:mm').format(dateTime)}h";
  }

  ///Método para formatar um valor double para o fomato de moeda 'Real Brasileiro - R$'
  static String doubleToCurrency(double value) {
    return NumberFormat.currency(symbol: "R\$").format(value);
  }

  ///Método para formatar numero
  static dynamic formatNumber(dynamic value) => Formaters._doubleToNumber(value);

  ///Método para truncar um valor double
  static String _doubleToNumber(dynamic value) => NumberFormat.decimalPattern().format(value);

  ///Método para retornar um Uint8List a partir de uma imagem em formato base64String
  static Uint8List dataFromBase64String(String base64String) => base64Decode(base64String);

  ///Método para retornar um base64Decode a partir de um Uint8List
  static String base64String(Uint8List data) => base64Encode(data);
}
