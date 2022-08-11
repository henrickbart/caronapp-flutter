import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/page/base.page.dart';
import 'package:caronapp/service/base.service.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customAppBar.widget.dart';
import 'package:caronapp/widget/customDateTimePicker.widget.dart';
import 'package:caronapp/widget/customLocationPicker.widget.dart';
import 'package:caronapp/widget/customPrimaryButton.widget.dart';
import 'package:caronapp/widget/customSnackBar.widget.dart';
import 'package:flutter/material.dart';

class CaronaSearchPage extends StatefulWidget {
  const CaronaSearchPage({Key? key}) : super(key: key);

  @override
  State<CaronaSearchPage> createState() => _CaronaSearchPageState();
}

class _CaronaSearchPageState extends State<CaronaSearchPage> {
  LocationResponse? _origin;
  LocationResponse? _destination;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Buscar caronas',
      ),
      body: SingleChildScrollView(
        child: BasePage(
          useHorizontalPadding: true,
          useVerticalPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                  onlyDate: true,
                  callback: (date) {
                    setState(() {
                      _date = date;
                    });
                  }),
              SizedBox(height: Theme.of(context).rowSize * 2),
              CustomPrimaryButton(
                  text: 'BUSCAR CARONA',
                  onPressed: () async {
                    String errorMessage = '';
                    if (_origin == null) {
                      errorMessage = 'Você deve selecionar o local de origem';
                    } else if (_destination == null) {
                      errorMessage = 'Você deve selecionar o local de destino';
                    } else if (_origin!.id == _destination!.id) {
                      errorMessage = 'O local de origem e de destino devem ser diferentes';
                    } else if (_date == null) {
                      errorMessage = 'Você deve selecionar para quando deseja a carona';
                    } else if (_date!.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
                      errorMessage = 'A data escolhida para a carona é inválida';
                    }

                    if (errorMessage.isNotEmpty) {
                      showSnackBar(
                          context,
                          CustomSnackBar.warning(
                            message: errorMessage,
                          ));
                    } else {
                      Navigator.pushNamed(context, caronaResultPage, arguments: [_origin!.id, _destination!.id, _date]);
                    }
                  },
                  state: NotifierState.initial),
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
}
