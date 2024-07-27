import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_data.dart';
import 'typography_data.dart';

ThemeData mainTheme(context) => ThemeData(
      primaryColor: kPrimaryColor,
      primarySwatch: kPrimary,
      scaffoldBackgroundColor: kFill,
      appBarTheme: AppBarTheme(
        backgroundColor: kFill,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.alice(
          color: kTitleColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kPrimaryColor,
        selectionColor: kPrimaryColor,
        selectionHandleColor: kPrimaryColor,
      ),
      textTheme: textTheme(context),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: kSecondaryColor,
        primary: kPrimaryColor,
        onPrimary: kWhiteColor,
        onSurface: kAccentColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: kPrimaryColor // button text color
            ),
      ),
    );
