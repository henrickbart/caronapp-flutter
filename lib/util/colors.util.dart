import 'package:flutter/material.dart';

///Classe responsavel pelas cores da aplicação
final MaterialColor primarySwatch = createMaterialColor(colorPrimary);
final MaterialColor secondarySwatch = createMaterialColor(colorSecondary);

const colorPrimary = Color(0xFF7400DB);
const colorSecondary = Color(0xF7E01B84);
const colorBackground = Color(0xFFF0F0F0);
const colorSurface = Color(0xFFFAFAFA);
const colorError = Color(0xFFDB005C);
const colorSuccess = Color(0xFF00DB72);
const colorWarning = Color.fromARGB(255, 240, 158, 6);
const colorDisabled = Color(0xFF7C7C7C);
const colorLabelOnPrimary = Color(0xFFFFFFFF);
const colorLabelOnSecondary = Color(0xFFFFFFFF);
const colorLabelOnSurface = Color(0xFF101010);
const colorLabelOnBackground = Color(0xFF050505);
const colorLabelOnError = Color(0xFFFFFFFF);
const colorLabelOnSuccess = Color(0xFFFFFFFF);
const colorLabelOnWarning = Color(0xFFFFFFFF);
const colorLabelOnEmpty = Color(0xFF505050);
const colorLabelOnDisabled = Color(0xFF101010);

ColorScheme colorScheme = ColorScheme(
    primary: colorPrimary,
    primaryContainer: primarySwatch.shade200,
    secondary: colorSecondary,
    secondaryContainer: secondarySwatch.shade200,
    surface: colorSurface,
    background: colorBackground,
    error: colorError,
    onPrimary: colorLabelOnPrimary,
    onSecondary: colorLabelOnSecondary,
    onSurface: colorLabelOnSurface,
    onBackground: colorLabelOnBackground,
    onError: colorLabelOnError,
    brightness: Brightness.light);

extension ColorSchemeExtension on ColorScheme {
  Color get success => colorSuccess;
  Color get onSuccess => colorLabelOnSuccess;
  Color get warning => colorWarning;
  Color get onWarning => colorLabelOnWarning;
  Color get onEmpty => colorLabelOnEmpty;
  Color get disabled => colorDisabled;
  Color get onDisabled => colorLabelOnDisabled;
  LinearGradient get gradient => LinearGradient(colors: [primary, secondary], begin: Alignment.bottomLeft, end: Alignment.topRight);
  LinearGradient get gradientAvatarImage => LinearGradient(colors: [secondary.withOpacity(0.33), primary.withOpacity(0.33)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  LinearGradient get gradientSourceDestination => LinearGradient(colors: [primary, secondary], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  LinearGradient get gradientCaronaEnded => LinearGradient(colors: [secondary.withOpacity(0.1), primary.withOpacity(0.1)], begin: Alignment.topLeft, end: Alignment.bottomRight);
}

///Metodo para criar o primarySwatch da aplicação
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};

  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;

    int position = (strength * 1000).round();

    Color color = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );

    swatch[position] = color;
  }

  return MaterialColor(color.value, {...swatch});
}
