import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const TextStyle largeTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.1875,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.71,
    letterSpacing: 0.16,
    fontFamily: 'Roboto',
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.25,
    fontFamily: 'Roboto',
  );

  static const TextStyle subhead = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    fontFamily: 'Roboto',
  );

}