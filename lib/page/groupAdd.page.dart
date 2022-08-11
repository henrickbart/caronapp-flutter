import 'package:caronapp/service/group.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/validator.util.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../service/base.service.dart';
import '../widget/customAppBar.widget.dart';
import '../widget/customPrimaryButton.widget.dart';
import '../widget/customTextFormField.widget.dart';
import 'base.page.dart';

///Página de cadastro para um novo usuario
class GroupAddPage extends StatefulWidget {
  const GroupAddPage({Key? key}) : super(key: key);

  @override
  GroupAddPageState createState() => GroupAddPageState();
}

class GroupAddPageState extends State<GroupAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlGroupName = TextEditingController();
  bool _autoValidate = false;
  GroupService? _service;

  @override
  void dispose() {
    _ctrlGroupName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service ??= Provider.of<GroupService>(context);

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Criar grupo',
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
                    title: 'Qual o nome do grupo?',
                    hint: 'Ex.: Amigos do Rogerinho',
                    keyboardType: TextInputType.text,
                    controller: _ctrlGroupName,
                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                    validatorFunction: (value) => Validators.isRequired(value)),
                SizedBox(height: Theme.of(context).rowSize * 2),
                CustomPrimaryButton(text: 'CRIAR', onPressed: () => createGroup(context), state: _service!.state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Método para cadastrar um novo grupo
  void createGroup(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _service!.addGroup(_ctrlGroupName.value.text);
      if (!mounted) return;

      if (_service!.state == NotifierState.loaded) {
        showSnackBar(context, const CustomSnackBar.success(message: 'Grupo criado com sucesso'));
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
