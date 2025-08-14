import 'package:flutter/material.dart';

class ThemeUtils {

  static ThemeMode getThemeMode() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 18) {
      // jam 6 pagi - 6 sore → light
      return ThemeMode.light;
    } else {
      // jam 6 sore - 6 pagi → dark
      return ThemeMode.dark;
    }
  }
}
