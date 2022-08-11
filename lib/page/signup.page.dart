import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/util/validator.util.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../service/account.service.dart';
import '../service/base.service.dart';
import '../widget/customAppBar.widget.dart';
import '../widget/customPrimaryButton.widget.dart';
import '../widget/customTextFormField.widget.dart';
import 'base.page.dart';

///Página de cadastro para um novo usuario
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();
  final _ctrlEmail = TextEditingController();
  final _ctrlCpf = TextEditingController();
  final _ctrlPhone = TextEditingController();
  final _ctrlPassword = TextEditingController();
  final _ctrlConfirmation = TextEditingController();
  bool _autoValidate = false;
  AccountService? _service;

  @override
  void dispose() {
    _ctrlName.dispose();
    _ctrlEmail.dispose();
    _ctrlCpf.dispose();
    _ctrlPhone.dispose();
    _ctrlPassword.dispose();
    _ctrlConfirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service ??= Provider.of<AccountService>(context);

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Cadastre-se',
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
                    title: 'CPF',
                    hint: '123.456.789-12',
                    keyboardType: TextInputType.number,
                    controller: _ctrlCpf,
                    inputFormatters: [MaskTextInputFormatter(mask: '###.###.###-##')],
                    validatorFunction: (value) => Validators.isCPF(value, true)),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                  title: 'Nome',
                  hint: 'Nome do usuário',
                  keyboardType: TextInputType.name,
                  controller: _ctrlName,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  validatorFunction: (value) => Validators.isRequired(value),
                ),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                  title: 'E-mail',
                  hint: 'exemplo@mail.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _ctrlEmail,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  validatorFunction: (value) => Validators.isEmail(value, true),
                ),
                SizedBox(height: 15.0.s),
                CustomTextFormField(
                  title: 'Telefone',
                  hint: '(99) 99999-9999',
                  keyboardType: TextInputType.phone,
                  controller: _ctrlPhone,
                  inputFormatters: [MaskTextInputFormatter(mask: '(##)#####-####')],
                  validatorFunction: (value) => Validators.isPhoneNumber(value, true),
                ),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                  title: 'Senha',
                  hint: 'Senha',
                  keyboardType: TextInputType.visiblePassword,
                  controller: _ctrlPassword,
                  validatorFunction: (value) => Validators.isRequired(value),
                  isPassword: true,
                ),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                  title: 'Confirmar senha',
                  hint: 'Confirmar senha',
                  keyboardType: TextInputType.visiblePassword,
                  controller: _ctrlConfirmation,
                  validatorFunction: (value) => Validators.isEquals('Senha', _ctrlPassword.text, 'Confirmar senha', value, true),
                  isPassword: true,
                ),
                SizedBox(height: Theme.of(context).rowSize * 2),
                CustomPrimaryButton(text: 'CADASTRAR', onPressed: () => validateSignup(context), state: _service!.state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Método para cadastrar um novo usuario
  void validateSignup(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _service!.signup(_ctrlName.value.text, _ctrlEmail.value.text, _ctrlCpf.value.text, _ctrlPhone.value.text, _ctrlPassword.value.text);
      if (!mounted) return;

      if (_service!.state == NotifierState.loaded) {
        showSnackBar(context, const CustomSnackBar.success(message: 'Cadastro realizado com sucesso'));
        Navigator.pushReplacementNamed(context, loginRoute);
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
