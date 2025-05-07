import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  //heading
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );
  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w300,
      letterSpacing: 0.2
  );

  //body text
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyMedium = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle bodySmall = GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2);


  //button text
  static TextStyle buttonLarge = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5);
  static TextStyle buttonMedium = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static TextStyle buttonSmall = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );


}
