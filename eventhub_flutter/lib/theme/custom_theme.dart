import 'package:eventhub_flutter/theme/custom_colors.dart';
import 'package:eventhub_flutter/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

extension CustomThemeExtension on ThemeData {
  CustomColors customColors(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? CustomColors.dark() : CustomColors.light();
  }

  CustomTextStyles customTextStyles(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomTextStyles.fromColorsAndScreenWidth(customColors(context), screenWidth);
  }
}

class CustomTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: MediaQuery.of(context).platformBrightness,
      
    );
  }
}

