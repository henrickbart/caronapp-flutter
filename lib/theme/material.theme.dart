// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

import '../util/colors.util.dart';
import '../util/fonts.util.dart';

///Tema da aplicação para Android
ThemeData materialTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
  primarySwatch: primarySwatch,
  primaryColor: colorPrimary,
  primaryColorLight: primarySwatch.shade200,
  primaryColorDark: primarySwatch.shade700,
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: colorBackground,
  textTheme: textTheme,
  colorScheme: colorScheme,
  cardColor: colorSurface,
  dividerColor: colorSecondary,
);
