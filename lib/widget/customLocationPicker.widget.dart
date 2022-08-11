import 'package:caronapp/model/response/locationResponse.model.dart';
import 'package:caronapp/util/colors.util.dart';
import 'package:caronapp/util/fonts.util.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:caronapp/widget/customGradientIcon.widget.dart';
import 'package:flutter/material.dart';

class CustomLocationPicker extends StatefulWidget {
  CustomLocationPicker({Key? key, required this.title, required this.locationType, required this.icon, required this.callback, this.location}) : super(key: key);

  final String title;
  final String locationType;
  final IconData icon;
  final Function(LocationResponse) callback;
  final LocationResponse? location;

  @override
  State<CustomLocationPicker> createState() => _CustomLocationPickerState();
}

class _CustomLocationPickerState extends State<CustomLocationPicker> {
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
                      widget.location != null
                          ? Text(
                              widget.location!.name,
                              style: Theme.of(context).textTheme.fieldContent,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              'Escolha ${widget.locationType}',
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
                  onTap: () => Navigator.pushNamed(context, locationPage).then(
                    (value) {
                      widget.callback(value as LocationResponse);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
