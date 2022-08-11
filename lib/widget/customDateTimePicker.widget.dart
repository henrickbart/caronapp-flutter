// ignore_for_file: unnecessary_null_comparison

import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/formaters.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customGradientIcon.widget.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatefulWidget {
  CustomDateTimePicker({Key? key, required this.title, required this.icon, required this.callback, this.onlyDate = false}) : super(key: key);

  final String title;
  final IconData icon;
  final Function(DateTime) callback;
  final bool onlyDate;

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 5.0.r),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.fieldLabel,
          ),
        ),
        SizedBox(height: 15.0.s),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0.r, horizontal: 10.0.r),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10.0.r),
                border: Border.all(width: 2.0.r, color: Theme.of(context).colorScheme.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GradientIcon(
                        widget.icon,
                        size: 20.s,
                      ),
                      SizedBox(width: 12.s),
                      dateTime != null
                          ? Text(
                              widget.onlyDate ? Formaters.dateTimeToDate(dateTime!) : Formaters.dateTimeToDateAndTime(dateTime!),
                              style: Theme.of(context).textTheme.fieldContent,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              widget.onlyDate ? 'Escolha a data' : 'Escolha a data e hora',
                              style: Theme.of(context).textTheme.fieldContentHint,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.disabled,
                    size: 20.s,
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0.r),
                  onTap: () async {
                    widget.onlyDate ? await _selectDate(context) : await _selectDateTime(context);

                    if (dateTime != null) {
                      widget.callback(dateTime!);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Método para selecionar a data
  Future<DateTime?> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;

        if (widget.onlyDate) {
          dateTime = DateTime(
            selectedDate!.year,
            selectedDate!.month,
            selectedDate!.day,
          );
        }
      });
    }
    return selectedDate;
  }

  //Método para selecionar a hora/minuto
  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  //Método para selecionar a data e hora
  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    if (!mounted) return;

    final time = await _selectTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }
}
