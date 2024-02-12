import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/theme/fonts.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: AppColors.primaryMaterialColor,
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(AppColors.whiteColor),
    fillColor: MaterialStateProperty.all(AppColors.secondaryColor),
  ),
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.scaffoldColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: AppFonts.plusJakartaSansBold,
          color: AppColors.secondaryTextColor)),
  //icon theme with design
  iconTheme: const IconThemeData(color: AppColors.primaryIconColor),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shadowColor: Colors.red,
      // This is a custom color variable
    ),
  ),
  //defining text theme with design
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontFamily: AppFonts.plusJakartaSansBold,
      color: AppColors.secondaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontFamily: AppFonts.plusJakartaSansMedium,
      color: AppColors.secondaryTextColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontFamily: AppFonts.plusJakartaSansRegular,
      color: AppColors.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      color: AppColors.secondaryTextColor,
      fontFamily: AppFonts.plusJakartaSansSemiBold,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
        color: AppColors.secondaryTextColor,
        fontFamily: AppFonts.plusJakartaSansLight,
        fontSize: 16,
        fontWeight: FontWeight.w700),
  ),
);
