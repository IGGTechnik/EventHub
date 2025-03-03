import 'package:eventhub_flutter/theme/custom_colors.dart';
import 'package:flutter/material.dart';

@immutable
class CustomTextStyles {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle appBarTitle;

  const CustomTextStyles({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.appBarTitle,
  });

  factory CustomTextStyles.fromColorsAndScreenWidth(CustomColors colors, double screenWidth) {
    return CustomTextStyles(
      displayLarge: TextStyle(
        fontSize: screenWidth > 500 ? 72 : screenWidth * 0.125,
        fontWeight: FontWeight.w800,
        fontFamily: 'Inter',
        letterSpacing: 0,
        color: colors.whiteText,
      ),
      displayMedium: TextStyle(
        fontSize: screenWidth > 500 ? 27 : screenWidth * 0.046,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        letterSpacing: 1,
        color: colors.whiteText,
      ),
      displaySmall: TextStyle(
        fontSize: screenWidth > 500 ? 20 : screenWidth * 0.034,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        letterSpacing: 1,
        color: colors.whiteText,
      ),
      appBarTitle: TextStyle(
        fontSize: screenWidth > 500 ? 27 : screenWidth * 0.046,
        fontWeight: FontWeight.w800,
        fontFamily: 'Inter',
        letterSpacing: 0,
        color: colors.whiteText,
      ),
    );
  }
}