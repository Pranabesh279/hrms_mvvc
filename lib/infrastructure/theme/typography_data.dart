import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_data.dart';

const String avenirFont = "Avenir";
const String flamaFont = "Flama";
const String interFont = "Inter";

TextTheme textTheme(BuildContext context) {
  // GoogleFonts.latoTextTheme(
  return TextTheme(
    displayLarge: GoogleFonts.lato(
      color: kTitleColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.lato(
      color: kTitleColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.lato(
      color: kTitleColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.lato(
      color: kTitleColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: GoogleFonts.lato(
      color: kTitleColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.alice(
      color: kTitleColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.lato(
      color: kTextColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.lato(
      color: kTextColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.alice(
      color: kTextColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    titleSmall: GoogleFonts.alice(
      color: kTextColor,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: GoogleFonts.lato(
      color: kTitleColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: GoogleFonts.lato(
      color: kTextColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: GoogleFonts.lato(
      color: kTextColor,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  );
  //);
}
