// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class myThemes {
  static final darkTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20)),
        prefixIconColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.white),
        labelStyle: const TextStyle(
          color: Colors.white,
        )),
    primaryColor: Colors.white,
    primaryColorLight: Colors.white,
    brightness: Brightness.light,
    canvasColor: Colors.white,
    primarySwatch: Colors.amber,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        scrolledUnderElevation: 12,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[400],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme:
        TextTheme(bodyLarge: const TextStyle().apply(color: Colors.white))
            .apply(decorationColor: Colors.white, bodyColor: Colors.white),
  );

  static final lightTheme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: Colors.black,
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black)),
      disabledColor: Colors.black,
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
      brightness: Brightness.dark,
      canvasColor: Colors.black,
      primarySwatch: Colors.amber,
      textTheme:
          TextTheme(bodyLarge: const TextStyle().apply(color: Colors.black))
              .apply(
        decorationColor: Colors.black,
        bodyColor: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.amber,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.amber,
          scrolledUnderElevation: 12,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber[400],
          unselectedItemColor: Colors.grey[900]));
}
