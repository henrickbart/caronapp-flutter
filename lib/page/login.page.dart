import 'package:caronapp/page/base.page.dart';
import 'package:caronapp/service/account.service.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customEllipseIcon.widget.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:caronapp/widget/customTextFormField.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../util/routes.util.dart';
import '../util/validator.util.dart';
import '../widget/customHyperlink.widget.dart';
import '../widget/customPrimaryButton.widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AccountService? _service;

  bool _autoValidate = false;

  final _formKey = GlobalKey<FormState>();

  final _ctrlLogin = TextEditingController();

  final _ctrlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _service ??= Provider.of<AccountService>(context);

    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(gradient: Theme.of(context).colorScheme.gradient),
        ),
        SingleChildScrollView(
          child: BasePage(
            useVerticalPadding: true,
            child: Container(
              margin: EdgeInsets.only(top: Theme.of(context).rowSize),
              padding: EdgeInsets.symmetric(
                horizontal: Theme.of(context).columnSize,
                vertical: Theme.of(context).rowSize,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0.s),
                color: Colors.white.withOpacity(0.75),
              ),
              width: Theme.of(context).columnSize * 13,
              height: Theme.of(context).rowSize * 26,
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: Theme.of(context).rowSize * 1),
                      SvgPicture.asset(
                        'assets/logo_horizontal.svg',
                        width: Theme.of(context).columnSize * 9,
                      ),
                      SizedBox(height: Theme.of(context).rowSize * 2),
                      CustomTextFormField(
                        title: 'E-mail',
                        hint: 'Insira o e-mail',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.emailAddress,
                        controller: _ctrlLogin,
                        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                        validatorFunction: (value) => Validators.isEmail(value, true),
                      ),
                      SizedBox(height: Theme.of(context).rowSize),
                      CustomTextFormField(
                        title: 'Senha',
                        hint: 'Insira a senha',
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _ctrlPassword,
                        validatorFunction: (value) => Validators.isRequired(value),
                        isPassword: true,
                      ),
                      SizedBox(height: Theme.of(context).rowSize),
                      CustomPrimaryButton(
                        text: 'ENTRAR',
                        onPressed: () => validateLogin(context),
                        state: _service!.state,
                      ),
                      SizedBox(height: Theme.of(context).rowSize / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Não possui uma conta? ', style: Theme.of(context).textTheme.bodyText),
                          CustomHyperlink(
                            text: 'Cadastre-se',
                            onTapAction: () {
                              Navigator.pushNamed(context, signupRoute);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: Theme.of(context).rowSize * 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 1.r,
                            width: Theme.of(context).columnSize * 4,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          Text(' ou ', style: Theme.of(context).textTheme.bodyText),
                          Container(
                            height: 1.r,
                            width: Theme.of(context).columnSize * 4,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ],
                      ),
                      SizedBox(height: Theme.of(context).rowSize * 1),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        CustomEllipseIcon(
                          ellipseSize: 50.r,
                          svgAsset: 'assets/google.svg',
                          iconHorizontalPosition: 0,
                          iconVerticalPosition: 0,
                          ellipseColor: Theme.of(context).colorScheme.secondary,
                          iconColor: Theme.of(context).colorScheme.onSecondary,
                          onTap: () => showMessage(context),
                        ),
                        CustomEllipseIcon(
                          ellipseSize: 50.r,
                          svgAsset: 'assets/facebook.svg',
                          iconHorizontalPosition: 0,
                          iconVerticalPosition: 0,
                          ellipseColor: Theme.of(context).colorScheme.secondary,
                          iconColor: Theme.of(context).colorScheme.onSecondary,
                          onTap: () => showMessage(context),
                        ),
                        CustomEllipseIcon(
                          ellipseSize: 50.r,
                          svgAsset: 'assets/twitter.svg',
                          iconHorizontalPosition: 0,
                          iconVerticalPosition: 0,
                          ellipseColor: Theme.of(context).colorScheme.secondary,
                          iconColor: Theme.of(context).colorScheme.onSecondary,
                          onTap: () => showMessage(context),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  ///Método para realizar login na aplicação
  void validateLogin(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _service!.login(_ctrlLogin.value.text, _ctrlPassword.value.text);
      if (!mounted) return;

      if (_service!.state == NotifierState.loaded) {
        Navigator.pushReplacementNamed(context, tabsPage);
      } else if (_service!.state == NotifierState.failure) {
        showSnackBar(
            context,
            CustomSnackBar.error(
              message: _service!.failure!.message,
            ));
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void showMessage(BuildContext context) {
    showSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Opa, vai com calma! Isso é só um trabalho de faculdade 😎",
        ));
  }
}
