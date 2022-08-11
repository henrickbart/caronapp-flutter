import 'package:caronapp/util/responsivity.util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.util.dart';

///Classe responsavel por guardar as fontes da aplicação
TextTheme textTheme = TextTheme(
  button: GoogleFonts.workSans(
    fontSize: 14.0.s,
    fontWeight: FontWeight.normal,
    color: colorLabelOnPrimary,
  ),
);

extension TextThemeExtension on TextTheme {
  TextStyle get buttonText => GoogleFonts.oxygen(fontSize: 14.0.s, fontWeight: FontWeight.w700, color: colorLabelOnPrimary);

  TextStyle get fieldLabel => GoogleFonts.oxygen(fontSize: 14.0.s, fontWeight: FontWeight.w500, color: colorLabelOnBackground);

  TextStyle get fieldContent => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w300, color: colorLabelOnSurface);

  TextStyle get fieldContentHint => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w300, color: colorLabelOnEmpty);

  TextStyle get fieldError => GoogleFonts.ubuntu(fontSize: 10.0.s, fontWeight: FontWeight.w300, color: colorError);

  TextStyle get hyperlink => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w300, color: colorPrimary);

  TextStyle get hyperlink2 => GoogleFonts.ubuntu(fontSize: 12.0.s2, fontWeight: FontWeight.w300, color: colorPrimary);

  TextStyle get bodyText => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w300, color: colorLabelOnBackground);

  TextStyle get bodyTextProfile => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get bodyTextProfile2 => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w400, color: colorError);

  TextStyle get snackBarText => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w300, color: colorLabelOnSurface);

  TextStyle get appBarTitle => GoogleFonts.oxygen(fontSize: 26.0.s, fontWeight: FontWeight.w400, color: colorLabelOnPrimary);

  TextStyle get appBarTitle2 => GoogleFonts.oxygen(fontSize: 26.0.s, fontWeight: FontWeight.w400, color: colorLabelOnBackground);

  TextStyle get appBarTitle3 => GoogleFonts.oxygen(fontSize: 26.0.s, fontWeight: FontWeight.w400, color: colorLabelOnPrimary);

  TextStyle get homeTitle => GoogleFonts.oxygen(fontSize: 30.0.s, fontWeight: FontWeight.w700, color: colorLabelOnBackground);

  TextStyle get homeSubtitle => GoogleFonts.ubuntu(fontSize: 24.0.s, fontWeight: FontWeight.w300, color: colorLabelOnBackground);

  TextStyle get homeBody => GoogleFonts.ubuntu(fontSize: 20.0.s, fontWeight: FontWeight.w300, color: colorLabelOnBackground);

  TextStyle get mainCardText => GoogleFonts.oxygen(fontSize: 18.0.s, fontWeight: FontWeight.w400, color: colorLabelOnPrimary);

  TextStyle get titleCaronaCard => GoogleFonts.ubuntu(fontSize: 16.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get topBarCaronaCard => GoogleFonts.ubuntu(fontSize: 16.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSecondary);

  TextStyle get bodyTextCaronaCard => GoogleFonts.ubuntu(fontSize: 16.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get bodyText1CaronaCard => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get bodyText2CaronaCard => GoogleFonts.ubuntu(fontSize: 12.0.s, fontWeight: FontWeight.w300, color: colorLabelOnEmpty);

  TextStyle get bodyText3CaronaCard => GoogleFonts.ubuntu(fontSize: 10.0.s, fontWeight: FontWeight.w300, color: colorLabelOnEmpty);

  TextStyle get profileSubtitle => GoogleFonts.ubuntu(fontSize: 24.0.s, fontWeight: FontWeight.w300, color: colorLabelOnPrimary);

  TextStyle get vehicleLabel => GoogleFonts.ubuntu(fontSize: 12.0.s, fontWeight: FontWeight.w300, color: colorLabelOnEmpty);

  TextStyle get vehicleContent => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get vehicleInfoLabel => GoogleFonts.ubuntu(fontSize: 10.0.s, fontWeight: FontWeight.w300, color: colorLabelOnEmpty);

  TextStyle get vehicleInfoContent => GoogleFonts.ubuntu(fontSize: 12.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get locationTitle => GoogleFonts.ubuntu(fontSize: 14.0.s, fontWeight: FontWeight.w400, color: colorLabelOnSurface);

  TextStyle get locationSubtitle => GoogleFonts.ubuntu(fontSize: 12.0.s, fontWeight: FontWeight.w400, color: colorLabelOnEmpty);

  TextStyle get shareCode => GoogleFonts.ubuntu(fontSize: 36.0.s, fontWeight: FontWeight.w500, color: colorPrimary);
}
