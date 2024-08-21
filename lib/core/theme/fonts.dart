import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static TextStyle alata(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color}) {
    return GoogleFonts.alata(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle popins(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle nunitoSans(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color}) {
    return GoogleFonts.nunitoSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}