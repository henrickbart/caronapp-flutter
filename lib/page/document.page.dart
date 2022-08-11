import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/validator.util.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../service/account.service.dart';
import '../service/base.service.dart';
import '../widget/customAppBar.widget.dart';
import '../widget/customPrimaryButton.widget.dart';
import '../widget/customTextFormField.widget.dart';
import 'base.page.dart';

///Página de cadastro dos documentos do usuario
class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  DocumentPageState createState() => DocumentPageState();
}

class DocumentPageState extends State<DocumentPage> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlDocument = TextEditingController();
  bool _autoValidate = false;
  AccountService? _service;

  @override
  void dispose() {
    _ctrlDocument.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service ??= Provider.of<AccountService>(context);

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Envio de CNH',
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
                    title: 'CNH',
                    hint: '11 dígitos numéricos',
                    keyboardType: TextInputType.number,
                    controller: _ctrlDocument,
                    inputFormatters: [MaskTextInputFormatter(mask: '###########')],
                    validatorFunction: (value) => Validators.isCNH(value, true)),
                SizedBox(height: Theme.of(context).rowSize * 2),
                CustomPrimaryButton(text: 'ENVIAR', onPressed: () => sendDocument(context), state: _service!.state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Método para cadastrar os documentos do usuario
  void sendDocument(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _service!.sendDocument(_ctrlDocument.value.text);
      if (!mounted) return;

      if (_service!.state == NotifierState.loaded) {
        showSnackBar(context, const CustomSnackBar.success(message: 'Documentação enviada com sucesso'));
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
