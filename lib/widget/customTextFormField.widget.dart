import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customGradientIcon.widget.dart';
import 'package:caronapp/widget/customGradientImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

///Classe responsável por criar um campo de texto customizado
class CustomTextFormField extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? prefixImage;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconOnTap;
  final bool isPassword;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onChanged;

  const CustomTextFormField({
    Key? key,
    this.title,
    this.hint,
    required this.keyboardType,
    required this.controller,
    this.prefixIcon,
    this.prefixImage,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.isPassword = false,
    this.validatorFunction,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  //variável booleana que indica se o texto deve ser ocultado quando o campo for uma senha
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.title != null,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 5.0.r),
            child: Text(
              widget.title != null ? widget.title! : '',
              style: Theme.of(context).textTheme.fieldLabel,
            ),
          ),
        ),
        Visibility(visible: widget.title != null, child: SizedBox(height: 15.0.s)),
        TextFormField(
          controller: widget.controller,
          validator: widget.validatorFunction,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style: Theme.of(context).textTheme.fieldContent,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.surface,
            filled: true,
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.fieldContentHint,
            errorStyle: Theme.of(context).textTheme.fieldError,
            errorMaxLines: 3,
            contentPadding: EdgeInsets.symmetric(vertical: device == DeviceType.mobile ? 14.0.r : 12.0.r, horizontal: 16.0.r),
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
            prefixIcon: widget.prefixIcon != null || widget.prefixImage != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                    child: widget.prefixIcon != null
                        ? GradientIcon(
                            widget.prefixIcon,
                            size: 18.0.s,
                          )
                        : GradientImage(widget.prefixImage!, size: 0),
                  )
                : null,
            suffixIcon: widget.isPassword ? buildVisibilityButton() : buildSuffixIcon(),
          ),
        ),
      ],
    );
  }

  Widget buildVisibilityButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.r, vertical: 3.0.r),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.elliptical(200, 200)),
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: GradientIcon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            size: 18.0.s,
          ),
        ),
      ),
    );
  }

  Widget? buildSuffixIcon() {
    return widget.suffixIcon != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0.r, vertical: 3.0.r),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.elliptical(200, 200)),
                onTap: widget.suffixIconOnTap,
                child: GradientIcon(
                  widget.suffixIcon,
                  size: 18.0.s,
                ),
              ),
            ),
          )
        : null;
  }
}
