// ignore_for_file: must_be_immutable
import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';

///Representa um item generico
class CustomGenericListItem extends StatelessWidget {
  final String title;
  final int index;
  final Widget? leading;
  final Widget? trailing;
  Function() onTap;

  CustomGenericListItem({
    Key? key,
    required this.title,
    required this.index,
    required this.onTap,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0.s, horizontal: 16.0.s),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
