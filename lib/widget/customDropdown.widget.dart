// ignore_for_file: must_be_immutable
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customGradientIcon.widget.dart';
import 'package:caronapp/widget/customGradientImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///cria um dropDown customizado
class CustomDropdown extends StatelessWidget {
  final Function(dynamic)? onChanged;
  final dynamic value;
  final List<DropdownMenuItem<Object>> items;
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final String? prefixImage;
  final String? Function(dynamic)? validatorFunction;

  CustomDropdown({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.items,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.prefixImage,
    this.validatorFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 5.0.r),
          child: Text(
            label,
            style: Theme.of(context).textTheme.fieldLabel,
          ),
        ),
        SizedBox(height: 15.0.s),
        DropdownButtonFormField<dynamic>(
          style: Theme.of(context).textTheme.fieldContent,
          isExpanded: true,
          hint: Text(
            onChanged == null
                ? "Carregando os dados..."
                : items.isEmpty
                    ? "Não há itens para seleção"
                    : hintText,
            style: Theme.of(context).textTheme.fieldContentHint,
          ),
          validator: validatorFunction,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            prefixIcon: prefixIcon != null || prefixImage != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                    child: prefixIcon != null
                        ? GradientIcon(
                            prefixIcon,
                            size: 18.0.s,
                          )
                        : Padding(
                            padding: EdgeInsets.all(2.0.s),
                            child: GradientImage(prefixImage!, size: 0),
                          ),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: prefixIcon != null || prefixImage != null ? 8.s : 14.s, vertical: 11.s),
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(width: 2.0.r, color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(width: 2.0.r, color: Theme.of(context).colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(width: 2.0.r, color: Theme.of(context).colorScheme.secondary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(width: 2.0.r, color: Theme.of(context).colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(width: 2.0.r, color: Theme.of(context).colorScheme.error),
            ),
          ),
          onChanged: onChanged,
          value: value,
          items: items,
        ),
      ],
    );
  }
}
