import 'package:flutter/material.dart';

@immutable
class CustomColors {
  final Color background;
  final Color surface;
  final Color whiteText;
  final Color darkerWhiteText;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color error;
  final Color success;

  final Color gradientInbetween;


  const CustomColors({
    required this.background,
    required this.surface,
    required this.whiteText,
    required this.darkerWhiteText,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.error,
    required this.success,
    required this.gradientInbetween,
  });
  
  factory CustomColors.dark() {
    return const CustomColors(
      background: Color(0xFF1A1A1A),
      surface: Color(0xFFF0F0F0),
      whiteText: Color(0xFFF0F0F0),
      darkerWhiteText: Color.fromARGB(255, 150, 150, 150),
      primary: Color(0xFF0054A3),
      secondary: Color(0xFF003566),
      accent: Color(0xFFFF4D1C),
      error: Color(0xFFFF3614),
      success: Color(0xFF34CD34),
      gradientInbetween: Color(0xFFA62D53),
    );
  }

  factory CustomColors.light() {
    return const CustomColors(
      background: Color(0xFFF0F0F0),
      surface: Color(0xFF1A1A1A),
      whiteText: Color(0xFFF0F0F0),
      darkerWhiteText: Color.fromARGB(255, 150, 150, 150),
      primary: Color(0xFF0054A3),
      secondary: Color(0xFF003566),
      accent: Color(0xFFFF4D1C),
      error: Color(0xFFFF3614),
      success: Color(0xFF34CD34),
      gradientInbetween: Color(0xFFA62D53),
    );
  }
}
