import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFFF3A712),
  ),
  useMaterial3: true,
);
var lightThemeData = lightTheme.copyWith(
  textTheme: GoogleFonts.belanosimaTextTheme(lightTheme.textTheme),
);

var darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xffF3A712),
  ),
  useMaterial3: true,
);
var darkThemeData = darkTheme.copyWith(
  textTheme: GoogleFonts.belanosimaTextTheme(darkTheme.textTheme),
);
