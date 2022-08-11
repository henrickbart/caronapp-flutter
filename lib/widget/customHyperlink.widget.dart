import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';

///Classe responsável por criar um HyperLink customizado
class CustomHyperlink extends StatelessWidget {
  final VoidCallback? onTapAction;
  final String text;
  final bool? smallerVersion;

  const CustomHyperlink({
    Key? key,
    required this.text,
    this.onTapAction,
    this.smallerVersion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10.0.s),
        onTap: onTapAction,
        child: Padding(
          padding: EdgeInsets.all(5.0.s),
          child: Text(text, style: smallerVersion ?? false ? Theme.of(context).textTheme.hyperlink2 : Theme.of(context).textTheme.hyperlink),
        ),
      ),
    );
  }
}
