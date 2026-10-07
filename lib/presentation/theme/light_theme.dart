import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/presentation/theme/app_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.main,
    onSurface: AppColors.main,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.main,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.main,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.main,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: AppColors.main,
      foregroundColor: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);
