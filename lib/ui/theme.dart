import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

 Color bluishClr = Colors.cyanAccent.shade700;
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
 Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      primaryColorLight: Colors.white,
      brightness: Brightness.light,
      scaffoldBackgroundColor:Colors.white,
      appBarTheme: AppBarTheme(color: Colors.white)
  );
  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      primaryColorDark: darkGreyClr,
      scaffoldBackgroundColor:Colors.black,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(color: darkGreyClr)
  );

}
  TextStyle get headingStyle{
    return GoogleFonts.adamina(
      textStyle:TextStyle(
        fontSize:25,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
  TextStyle get subheadingstyle{
    return GoogleFonts.adamina(
      textStyle:TextStyle(
        fontSize:22,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
  TextStyle get titlestyle{
    return GoogleFonts.adamina(
      textStyle:TextStyle(
        fontSize:18,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
  TextStyle get subTitleStyle{
    return GoogleFonts.adamina(
      textStyle:TextStyle(
        fontSize:16,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
  TextStyle get bodyStyle{
    return GoogleFonts.adamina(
      textStyle:TextStyle(
        fontSize:14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
  TextStyle get body2Style{
    return GoogleFonts.adamina(
      textStyle:TextStyle(
        fontSize:14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
      ),
    );
  }