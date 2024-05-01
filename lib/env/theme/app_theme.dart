import 'package:flutter/material.dart';


class AppTheme {
  // * COLORS GLOBALES
  static const Color primaryColor = Color(0xFFFFC836);
  static const Color secondaryColor = Color(0xff009BDD);
  static const Color white = Color(0xFFFFFFFF);
  static const Color backgroundHome = Color(0xFFF1F1F1);
  static const Color bordergrey = Color(0xFFB1B1B1);
  static const Color hinText = Color(0xff5B5B5B);
  static const Color transparent = Color(0x00000000);
  static const Color error = Color(0xffF94838);
  static const Color grey = Color(0xffE4E4E4);
  static const Color textCalendar = Color(0xff9A9999);
  static const Color dividerColor = Color(0xFFCACACA);

  // * COLOR DE LAS TARJETAS
  static const Color textCard = Color(0xff4B4B4B);
  static const Color colorCardSchedule = Color.fromARGB(255, 178, 187, 255);

  // * ASSETS APP
  static const String logoSplash = "assets/splash/logo_splash.svg";
  static const String icon404Path = "assets/404.svg";
  static const String iconErrorPath = "assets/error.svg";
  static const String iconCautionPath = "assets/caution.svg";
  static const String iconNotFoundImagePath = "assets/user.svg";
  static const String gifLoadingPath = "assets/loading.gif";


  ThemeData theme() {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: AppTheme.primaryColor,
          cursorColor: AppTheme.primaryColor),
      filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(error))),
      useMaterial3: true,
    );
  } 
}
