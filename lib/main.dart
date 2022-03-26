import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home.dart';

void main() {
  runApp(GetMaterialApp(
    home: Home(),
    title: "Sat Streamer",
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      backgroundColor: Colors.purple[600],

      // Define the default font family.
      fontFamily: 'Georgia',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              primary: Colors.purple,
              textStyle: const TextStyle(color: Colors.purple))),

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.purple),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
  ));
}
