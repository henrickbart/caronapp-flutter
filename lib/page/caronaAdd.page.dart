import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/model/response/userVehicleResponse.model.dart';
import 'package:caronapp/page/base.page.dart';
import 'package:caronapp/service/account.service.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/service/carona.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/validator.util.dart';
import 'package:caronapp/widget/customAppBar.widget.dart';
import 'package:caronapp/widget/customDateTimePicker.widget.dart';
import 'package:caronapp/widget/customDropdown.widget.dart';
import 'package:caronapp/widget/customLocationPicker.widget.dart';
import 'package:caronapp/widget/customPrimaryButton.widget.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:caronapp/widget/customTextFormField.widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CaronaAddPage extends StatefulWidget {
  const CaronaAddPage({Key? key, this.groupID}) : super(key: key);

  final int? groupID;

  @override
  State<CaronaAddPage> createState() => _CaronaAddPageState();
}

class _CaronaAddPageState extends State<CaronaAddPage> {
  CaronaService? _serviceCarona;
  AccountService? _serviceAccount;

  List<UserVehicleResponse> _userVehicles = List.empty(growable: true);

  LocationResponse? _origin;
  LocationResponse? _destination;
  DateTime? _date;
  UserVehicleResponse? _userVehicle;
  final _ctrlAvaiableSeats = TextEditingController();
  final _ctrlPrice = TextEditingController();
  final currencyFormatter = CurrencyTextInputFormatter(locale: 'pt-BR', symbol: 'R\$');

  @override
  void dispose() {
    _ctrlAvaiableSeats.dispose();
    _ctrlPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_serviceCarona == null || _serviceAccount == null) {
      _serviceCarona = Provider.of<CaronaService>(context);
      _serviceAccount = Provider.of<AccountService>(context);

      loadUserVehiclesList(false);
    }

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Oferecer caronas',
      ),
      body: SingleChildScrollView(
        child: BasePage(
          useHorizontalPadding: true,
          useVerticalPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomDropdown(
                label: 'Qual veículo você irá utilizar?',
                hintText: 'Escolha o veículo',
                value: _userVehicle,
                prefixImage: 'assets/icon_car.svg',
                validatorFunction: (value) => Validators.isDropdownRequired(value),
                items: _userVehicles.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text("${item.plate.toUpperCase()} | ${item.brand} ${item.model}", overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: _serviceAccount!.state == NotifierState.loading
                    ? null
                    : (value) {
                        setState(() {
                          _userVehicle = value;
                        });
                      },
              ),
              SizedBox(height: Theme.of(context).rowSize),
              CustomLocationPicker(
                  title: "De onde você vai sair?",
                  locationType: 'a origem',
                  icon: Icons.circle_outlined,
                  location: _origin,
                  callback: (location) {
                    setState(() {
                      _origin = location;
                    });
                  }),
              SizedBox(height: Theme.of(context).rowSize),
              CustomLocationPicker(
                  title: "Para onde você vai?",
                  locationType: 'o destino',
                  icon: Icons.gps_fixed,
                  location: _destination,
                  callback: (location) {
                    setState(() {
                      _destination = location;
                    });
                  }),
              SizedBox(height: Theme.of(context).rowSize),
              CustomDateTimePicker(
                  title: "Quando você vai?",
                  icon: Icons.calendar_month,
                  callback: (date) {
                    setState(() {
                      _date = date;
                    });
                  }),
              SizedBox(height: Theme.of(context).rowSize),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: _ctrlAvaiableSeats,
                prefixImage: 'assets/icon_seat.svg',
                title: 'Quantos lugares disponíveis?',
                hint: "Informe a quantidade",
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: Theme.of(context).rowSize),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: _ctrlPrice,
                prefixImage: 'assets/icon_money.svg',
                title: 'Quanto você quer cobrar por passageiro?',
                hint: "Informe o valor",
                inputFormatters: [currencyFormatter],
              ),
              SizedBox(height: Theme.of(context).rowSize * 2),
              CustomPrimaryButton(
                  text: 'OFERECER CARONA',
                  onPressed: () async {
                    String errorMessage = '';
                    if (_userVehicle == null) {
                      errorMessage = 'Você deve selecionar o veículo que irá utilizar para essa carona';
                    } else if (_origin == null) {
                      errorMessage = 'Você deve selecionar o local de origem';
                    } else if (_destination == null) {
                      errorMessage = 'Você deve selecionar o local de destino';
                    } else if (_origin!.id == _destination!.id) {
                      errorMessage = 'O local de origem e de destino devem ser diferentes';
                    } else if (_date == null) {
                      errorMessage = 'Você deve selecionar quando irá oferecer a carona';
                    } else if (_date!.isBefore(DateTime.now())) {
                      errorMessage = 'A data escolhida para a carona é inválida';
                    } else if (_ctrlAvaiableSeats.text.isEmpty) {
                      errorMessage = 'Você deve informar quantos lugares estarão disponíveis';
                    } else if (int.parse(_ctrlAvaiableSeats.text) > _userVehicle!.seats || int.parse(_ctrlAvaiableSeats.text) <= 0) {
                      errorMessage = 'A quantidade de lugares disponíveis é inválida. Ao menos 1 e no máximo ${_userVehicle!.seats} poderão estar disponíveis.';
                    } else if (_ctrlPrice.text.isEmpty) {
                      errorMessage = 'Você deve informar quanto quer cobrar por passageiro';
                    } else if (currencyFormatter.getUnformattedValue() <= 0) {
                      errorMessage = 'O valor cobrado deve ser maior que 0';
                    }

                    if (errorMessage.isNotEmpty) {
                      showSnackBar(
                          context,
                          CustomSnackBar.warning(
                            message: errorMessage,
                          ));
                    } else {
                      await _serviceCarona!.addCarona(_origin!.id!, _destination!.id!, _userVehicle!.id, _date!, int.parse(_ctrlAvaiableSeats.text), double.parse(currencyFormatter.getUnformattedValue().toString()), widget.groupID);

                      if (!mounted) return;

                      if (_serviceCarona!.state == NotifierState.loaded) {
                        showSnackBar(context, const CustomSnackBar.success(message: 'Carona oferecida com sucesso'));
                        Navigator.pop(context);
                      } else if (_serviceCarona!.state == NotifierState.failure) {
                        showSnackBar(context, CustomSnackBar.error(message: _serviceCarona!.failure!.message));
                      }
                    }
                  },
                  state: _serviceCarona!.state),
            ],
          ),
        ),
      ),
    );
  }

  void callback(LocationResponse response) {
    setState(() {
      _origin = response;
    });
  }

  //Função para carregar a lista de carros da API
  Future<void> loadUserVehiclesList([bool notifyListener = true]) async {
    _userVehicles = await _serviceAccount!.getUserVehicles(notifyListener);
  }
}
