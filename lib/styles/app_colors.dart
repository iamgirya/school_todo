import 'package:flutter/material.dart';

class ToDoAppDarkColors extends ToDoAppColors{
  const ToDoAppDarkColors(Color importTaskColor) : super(
    separator: const Color(0x33FFFFFF),
    overlay: const Color(0x52000000),
    primary: const Color(0xFFFFFFFF),
    secondary: const Color(0x99FFFFFF),
    tertiary: const Color(0x66FFFFFF),
    disable: const Color(0x26FFFFFF),
    red: const Color(0xFFFF3B30),
    green: const Color(0xFF34C759),
    blue: const Color(0xFF007AFF),
    gray: const Color(0xFF8E8E93),
    backgroundPrimary: const Color(0xFF161618),
    backgroundSecondary: const Color(0xFF252528),
    backgroundElevated: const Color(0xFF3C3C3F  ),
    importTaskColor: importTaskColor,
  );
}

class ToDoAppLightColors extends ToDoAppColors{
  const ToDoAppLightColors(Color importTaskColor) : super(
    separator: const Color(0x33000000),
    overlay: const Color(0x0F000000),
    primary: const Color(0xFF000000),
    secondary: const Color(0x99000000),
    tertiary: const Color(0x4D000000),
    disable: const Color(0x26000000),
    red: const Color(0xFFFF453A),
    green: const Color(0xFF32D74B),
    blue: const Color(0xFF0A84FF),
    gray: const Color(0xFF8E8E93),
    backgroundPrimary: const Color(0xFFF7F6F2),
    backgroundSecondary: const Color(0xFFFFFFFF),
    backgroundElevated: const Color(0xFFFFFFFF),
    importTaskColor: importTaskColor,
  );
}

class ToDoAppColors extends ThemeExtension<ToDoAppColors> {
  const ToDoAppColors({
    required this.separator,
    required this.overlay,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.disable,
    required this.red,
    required this.green,
    required this.blue,
    required this.gray,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundElevated,
    required this.importTaskColor,
  });

  final Color? separator;
  final Color? overlay;

  final Color? primary;
  final Color? secondary;
  final Color? tertiary;
  final Color? disable;

  final Color? red;
  final Color? green;
  final Color? blue;
  final Color? gray;

  final Color? backgroundPrimary;
  final Color? backgroundSecondary;
  final Color? backgroundElevated;

  final Color? importTaskColor;

  @override
  ToDoAppColors copyWith({
    Color? separator,
    Color? overlay,
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? disable,
    Color? red,
    Color? green,
    Color? blue,
    Color? gray,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundElevated,
    Color? importTaskColor,
  }) {
    return ToDoAppColors(
      separator: separator ?? this.separator,
      overlay: overlay ?? this.overlay,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      disable: disable ?? this.disable,
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      gray: gray ?? this.gray,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundElevated: backgroundElevated ?? this.backgroundElevated,
      importTaskColor: importTaskColor ?? this.importTaskColor,
    );
  }

  @override
  ToDoAppColors lerp(ThemeExtension<ToDoAppColors>? other, double t) {
    if (other is! ToDoAppColors) {
      return this;
    }
    return ToDoAppColors(
      separator: Color.lerp(separator, other.separator, t),
      overlay: Color.lerp(overlay, other.overlay, t),
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      tertiary: Color.lerp(tertiary, other.tertiary, t),
      disable: Color.lerp(disable, other.disable, t),
      red: Color.lerp(red, other.red, t),
      green: Color.lerp(green, other.green, t),
      blue: Color.lerp(blue, other.blue, t),
      gray: Color.lerp(gray, other.gray, t),
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t),
      backgroundSecondary: Color.lerp(backgroundSecondary, other.backgroundSecondary, t),
      backgroundElevated: Color.lerp(backgroundElevated, other.backgroundElevated, t),
      importTaskColor: Color.lerp(importTaskColor, other.importTaskColor, t),
    );
  }
 }