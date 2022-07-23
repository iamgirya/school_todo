import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle largeTitle = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.1875,
    fontFamily: "Roboto",
  );
  
  static TextStyle title = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0.5,
    fontFamily: "Roboto",
  );

  static TextStyle button = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.71,
    letterSpacing: 0.16,
    fontFamily: "Roboto",
  );

  static TextStyle body = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    fontFamily: "Roboto",
  );

  static TextStyle subhead = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    fontFamily: "Roboto",
  );

}