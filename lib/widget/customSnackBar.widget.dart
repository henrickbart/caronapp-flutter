import 'package:caronapp/main.dart';
import 'package:caronapp/model/viewModel/snackBarType.model.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';

///Classe responsável por renderizar as mensagens customizadas da aplicação, de acordo com o tipo da mesma
class CustomSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const CustomSnackBar({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  ///Construtor nomeado para exibir uma mensagem de sucesso
  const CustomSnackBar.success({
    Key? key,
    required this.message,
    this.type = SnackBarType.Success,
  }) : super(key: key);

  ///Construtor nomeado para exibir uma mensagem de informação
  const CustomSnackBar.info({
    Key? key,
    required this.message,
    this.type = SnackBarType.Info,
  }) : super(key: key);

  ///Construtor nomeado para exibir uma mensagem de erro
  const CustomSnackBar.error({
    Key? key,
    required this.message,
    this.type = SnackBarType.Error,
  }) : super(key: key);

  ///Construtor nomeado para exibir uma mensagem de aviso
  const CustomSnackBar.warning({
    Key? key,
    required this.message,
    this.type = SnackBarType.Warning,
  }) : super(key: key);

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      padding: const EdgeInsets.all(0),
      duration: getDuration(),
      margin: EdgeInsets.all(10.0.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      action: SnackBarAction(
        label: "x",
        textColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        onPressed: () => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(reason: SnackBarClosedReason.hide),
      ),
      content: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0.r)),
                  color: _getColor(context),
                ),
              ),
            ),
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0.r,
                )),
            Flexible(
              flex: 2,
              child: Icon(_getIcon(), color: _getColor(context)),
            ),
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0.r,
                )),
            Flexible(
              flex: 30,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0.r),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.snackBarText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Método para renderizar o widget e obter uma SnackBar
  SnackBar _getSnackBar(BuildContext context) {
    return build(context);
  }

  ///Método para obter duração da mensagem de acordo com o seu tipo
  Duration getDuration() {
    switch (type) {
      case SnackBarType.Success:
        return const Duration(seconds: 1);
      case SnackBarType.Info:
        return const Duration(seconds: 5); //10
      case SnackBarType.Warning:
        return const Duration(seconds: 5); //10
      case SnackBarType.Error:
        return const Duration(seconds: 5); //10
    }
  }

  ///Método para obter a cor primária do snackbar de acordo com o tipo
  Color _getColor(BuildContext context) {
    switch (type) {
      case SnackBarType.Success:
        return Theme.of(context).colorScheme.success;
      case SnackBarType.Info:
        return Theme.of(context).colorScheme.primary;
      case SnackBarType.Warning:
        return Theme.of(context).colorScheme.warning;
      case SnackBarType.Error:
        return Theme.of(context).colorScheme.error;
    }
  }

  ///Método para obter o ícone do snackbar de acordo com o tipo
  IconData _getIcon() {
    switch (type) {
      case SnackBarType.Success:
        return Icons.check_circle;
      case SnackBarType.Info:
        return Icons.info;
      case SnackBarType.Warning:
        return Icons.error;
      case SnackBarType.Error:
        return Icons.cancel;
    }
  }
}

///Método para exibir um SnackBar quando necessário
void showSnackBar(BuildContext context, CustomSnackBar customSnackBar) {
  ScaffoldMessenger.of(context).showSnackBar(customSnackBar._getSnackBar(context));
}
