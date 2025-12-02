import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF011749);
  static const Color accentColor = Color(0xFFE7A01C);
  static const Color greyColor = Color(0xFF717070);
}

class AppImages {
  static const String logo = 'assets/images/petopia_logo.png';
}

class AppTheme {
  static var theme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: AppColors.greyColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      bodyMedium: GoogleFonts.poppins(
        color: AppColors.greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.poppins(
        color: AppColors.greyColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            textStyle: GoogleFonts.poppins(
              color: Colors.white,
            )
        )
    ),
    iconTheme: IconThemeData(
      color: AppColors.greyColor,
    ),
    colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.greyColor, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.greyColor, width: 1),
      ), // Example: Set a default outline border
      labelStyle: GoogleFonts.inter(
        color: AppColors.greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      focusColor: AppColors.primaryColor,
      // Example: Style for the label text
      hintStyle: GoogleFonts.inter(
        color: AppColors.greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ), // Example: Style for the hint text
      contentPadding: EdgeInsets.all(16.0),

      // Example: Default content padding
      // Add other InputDecoration properties as needed
    ),
  );
}
