// reusable stepper button
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const StepperButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: AppColors.primaryButton),
    );
  }
}