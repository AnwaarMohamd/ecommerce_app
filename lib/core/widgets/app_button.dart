import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? (backgroundColor ?? AppColors.grey)
              : AppColors.greyDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: enabled ? 4 : 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: enabled ? (textColor ?? AppColors.orangeDark) : AppColors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
