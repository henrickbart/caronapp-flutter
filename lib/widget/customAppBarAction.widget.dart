import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';

///Classe responsável por criar uma ação de um AppBar customizado
class CustomAppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? function;

  const CustomAppBarAction({
    Key? key,
    required this.icon,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: function,
        child: Container(
          padding: EdgeInsets.all(8.0.s),
          child: Icon(
            icon,
            size: 24.0.s,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
