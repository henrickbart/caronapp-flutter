import 'package:caronapp/service/group.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/validator.util.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:caronapp/widget/customUpperCaseTextFormatter.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../service/base.service.dart';
import '../widget/customAppBar.widget.dart';
import '../widget/customPrimaryButton.widget.dart';
import '../widget/customTextFormField.widget.dart';
import 'base.page.dart';

///Página de cadastro para um novo usuario
class GroupAddByCodePage extends StatefulWidget {
  const GroupAddByCodePage({Key? key}) : super(key: key);

  @override
  GroupAddByCodePageState createState() => GroupAddByCodePageState();
}

class GroupAddByCodePageState extends State<GroupAddByCodePage> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlCode = TextEditingController();
  bool _autoValidate = false;
  GroupService? _service;

  @override
  void dispose() {
    _ctrlCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service ??= Provider.of<GroupService>(context);

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Entrar usando código',
      ),
      body: SingleChildScrollView(
        child: BasePage(
          useHorizontalPadding: true,
          useVerticalPadding: true,
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                    title: 'Qual o código do grupo?',
                    hint: 'Ex.: 5d3S4, h27aS',
                    keyboardType: TextInputType.visiblePassword,
                    controller: _ctrlCode,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: '#####', filter: {"#": RegExp(r'[a-zA-Z0-9]')})
                    ],
                    validatorFunction: (value) => Validators.isAlphaNumeric(value, true)),
                SizedBox(height: Theme.of(context).rowSize * 2),
                CustomPrimaryButton(text: 'ENTRAR', onPressed: () => enterGroup(context), state: _service!.state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Método para cadastrar um novo grupo
  void enterGroup(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _service!.addGroupByCode(_ctrlCode.value.text);
      if (!mounted) return;

      if (_service!.state == NotifierState.loaded) {
        showSnackBar(context, const CustomSnackBar.success(message: 'Você entrou no grupo com sucesso'));
        Navigator.pop(context);
      } else if (_service!.state == NotifierState.failure) {
        showSnackBar(context, CustomSnackBar.error(message: _service!.failure!.message));
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
