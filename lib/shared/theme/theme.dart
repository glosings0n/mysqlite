import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 2,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.deepOrange,
      fontSize: 15,
    ),
    iconTheme: IconThemeData(
      color: Colors.deepOrange,
      size: 15,
    ),
  ),
  primarySwatch: Colors.deepOrange,
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
    shape: StadiumBorder(),
    iconSize: 15,
    focusColor: Colors.deepOrangeAccent,
    foregroundColor: Colors.white,
    focusElevation: 1,
    elevation: 5,
    enableFeedback: false,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 7,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.deepOrange,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(5.0),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    elevation: 2,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.deepOrange,
      fontSize: 15,
    ),
    iconTheme: IconThemeData(
      color: Colors.deepOrange,
      size: 15,
    ),
  ),
  primarySwatch: Colors.deepOrange,
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
    shape: StadiumBorder(),
    iconSize: 15,
    focusColor: Colors.deepOrangeAccent,
    foregroundColor: Colors.black,
    focusElevation: 1,
    elevation: 5,
    enableFeedback: false,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 7,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.deepOrange,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(5.0),
    ),
  ),
);
