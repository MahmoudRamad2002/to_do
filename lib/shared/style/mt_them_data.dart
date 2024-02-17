import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/shared/style/app_color.dart';

class myThemeData {
  static const Color lightColor = Color(0xFF5D9CEC);
  static ThemeData ligthTheme = ThemeData(
      scaffoldBackgroundColor: appColor.lightGreenColor,
      primaryColor: lightColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: appColor.lightColor,
        unselectedItemColor: appColor.GryColor,
      ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: appColor.lightColor),
        bodySmall: GoogleFonts.roboto(
          color: Colors.black54,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ));
}
