import 'package:blog_app/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(AppPallete.errorColor)),
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      chipTheme: const ChipThemeData(
          side: BorderSide.none,
          color: WidgetStatePropertyAll(AppPallete.backgroundColor)));
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 3));
}
