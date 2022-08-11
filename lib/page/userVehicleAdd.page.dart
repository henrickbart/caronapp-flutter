import 'package:caronapp/page/base.page.dart';
import 'package:caronapp/service/account.service.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/validator.util.dart';
import 'package:caronapp/widget/customAppBar.widget.dart';
import 'package:caronapp/widget/customDropdown.widget.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:caronapp/widget/customTextFormField.widget.dart';
import 'package:caronapp/widget/customUpperCaseTextFormatter.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../model/response/vehicleResponse.model.dart';
import '../widget/customPrimaryButton.widget.dart';

class UserVehicleAddPage extends StatefulWidget {
  const UserVehicleAddPage({Key? key}) : super(key: key);

  @override
  State<UserVehicleAddPage> createState() => _UserVehicleAddPageState();
}

class _UserVehicleAddPageState extends State<UserVehicleAddPage> {
  AccountService? _service;
  bool _autoValidate = false;

  List<VehicleResponse> _vehicles = List.empty(growable: true);
  VehicleResponse? _selectedVehicle;

  final _formKey = GlobalKey<FormState>();
  final _ctrlColor = TextEditingController();
  final _ctrlYear = TextEditingController();
  final _ctrlPlate = TextEditingController();
  final _ctrlRENAVAM = TextEditingController();

  @override
  void dispose() {
    _ctrlColor.dispose();
    _ctrlYear.dispose();
    _ctrlPlate.dispose();
    _ctrlRENAVAM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      _service = Provider.of<AccountService>(context);
      loadList(false);
    }
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Cadastrar veículo'),
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
                CustomDropdown(
                  label: 'Qual o veículo?',
                  hintText: 'Escolha o veículo',
                  value: _selectedVehicle,
                  validatorFunction: (value) => Validators.isDropdownRequired(value),
                  items: _vehicles.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text("${item.brand} ${item.model}"),
                    );
                  }).toList(),
                  onChanged: _service!.state == NotifierState.loading
                      ? null
                      : (value) {
                          setState(() {
                            _selectedVehicle = value;
                          });
                        },
                ),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                    title: 'Qual a cor?',
                    hint: 'Ex.: Preto, Vermelho',
                    keyboardType: TextInputType.text,
                    controller: _ctrlColor,
                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                    validatorFunction: (value) => Validators.isRequired(value)),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                    title: 'Qual o ano?',
                    hint: 'Ex.: 2012, 2017',
                    keyboardType: TextInputType.number,
                    controller: _ctrlYear,
                    inputFormatters: [MaskTextInputFormatter(mask: '####')],
                    validatorFunction: (value) => Validators.isRequired(value)),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                    title: 'Qual a placa?',
                    hint: 'Ex.: RBH5J24, QRE2H12',
                    keyboardType: TextInputType.visiblePassword,
                    controller: _ctrlPlate,
                    inputFormatters: [MaskTextInputFormatter(mask: 'AAA#A##'), UpperCaseTextFormatter()],
                    validatorFunction: (value) => Validators.isPlate(value, true)),
                SizedBox(height: Theme.of(context).rowSize),
                CustomTextFormField(
                    title: 'Qual o RENAVAM?',
                    hint: '11 dígitos numéricos',
                    keyboardType: TextInputType.number,
                    controller: _ctrlRENAVAM,
                    inputFormatters: [MaskTextInputFormatter(mask: '###########')],
                    validatorFunction: (value) => Validators.isRENAVAM(value, true)),
                SizedBox(height: Theme.of(context).rowSize * 2),
                CustomPrimaryButton(text: 'SALVAR', onPressed: () => validateAddVehicle(context), state: _service!.state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Função para carregar a lista de carros da API
  Future<void> loadList([bool notifyListener = true]) async {
    _vehicles = await _service!.getVehicles(notifyListener);
  }

  ///Método para cadastrar um novo usuario
  void validateAddVehicle(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _service!.addUserVehicle(_selectedVehicle!.id, _ctrlColor.value.text, int.parse(_ctrlYear.value.text), _ctrlPlate.value.text, _ctrlRENAVAM.value.text);
      if (!mounted) return;

      if (_service!.state == NotifierState.loaded) {
        showSnackBar(context, const CustomSnackBar.success(message: 'Veículo cadastrado com sucesso'));
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
