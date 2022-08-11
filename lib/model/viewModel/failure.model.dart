///Classe com modelo da mensagem de falha
class Failure {
  final String message;
  final int statusCode;

  Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => statusCode.toString() + message;
}
