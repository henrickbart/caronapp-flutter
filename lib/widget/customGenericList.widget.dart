import 'package:caronapp/widget/customGenericListItem.widget.dart';
import 'package:flutter/material.dart';

///Constroi uma lista de items genericos
class CustomGenericList extends StatelessWidget {
  final List<CustomGenericListItem> list;

  const CustomGenericList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          return list[index];
        });
  }
}
