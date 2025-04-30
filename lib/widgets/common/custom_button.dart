import 'package:cet_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({
    super.key, 
    required this.title, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            AppColors.gradientStartColor,
            AppColors.gradientEndColor,
          ]),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Text(
            title,
            style: AppFonts.titleTextFont
          ),
        ),
      ),
    );
  }
}