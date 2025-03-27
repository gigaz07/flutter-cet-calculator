import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color backgroundColor          = Color(0xFF15151D);
  static const Color primaryColor             = Color(0xFF20202C);
  static const Color darkTextColor            = Color(0xFF797883);
  static const Color lightTextColor           = Color(0xFFFFFFFF);
  static const Color gradientStartColor       = Color(0xFFFF0000);
  static const Color gradientEndColor         = Color(0xFFFF8800);
}

class AppFonts {
  static final TextStyle mainTextFont         = GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.lightTextColor);
  static final TextStyle hintTextFont         = GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.darkTextColor);
  static final TextStyle titleTextFont        = GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.lightTextColor);
  static final TextStyle resultTextFont       = GoogleFonts.inter(fontSize: 64, fontWeight: FontWeight.w400, color: AppColors.lightTextColor);
  static final TextStyle resultUnitTextFont   = GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400, color: AppColors.lightTextColor);
}