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
   static TextStyle ubuntu(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color}) {
    return GoogleFonts.ubuntu(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
     static TextStyle firasans(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color}) {
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

}

TextStyle getHeebo(FontWeight fontWeight, double fontSize, Color fontColor) {
  return GoogleFonts.heebo(
      fontWeight: fontWeight, fontSize: fontSize, color: fontColor);
}