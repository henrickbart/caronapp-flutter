import 'package:caronapp/util/buttons.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import '../service/base.service.dart';

///Classe responsável por renderizar um botão primário customizado
class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final NotifierState state;

  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case NotifierState.loading:
        return SizedBox(
          height: Theme.of(context).rowSize * 2,
          child: ElevatedButton(
            onPressed: null,
            style: buttonStylePrimary,
            child: SizedBox(width: Theme.of(context).rowSize, child: const CircularProgressIndicator()),
          ),
        );

      default:
        return SizedBox(
          height: Theme.of(context).rowSize * 2,
          child: ElevatedButton(
              style: buttonStylePrimary,
              onPressed: onPressed,
              child: Text(
                text,
                style: Theme.of(context).textTheme.buttonText,
              )),
        );
    }
  }
}
