// reusable circle icon button
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColors.glassWhite,
        child: Icon(icon, color: AppColors.white),
      ),
    );
  }
}
