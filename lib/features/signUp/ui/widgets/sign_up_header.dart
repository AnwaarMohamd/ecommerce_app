import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Create your account',
          style: AppTextStyles.font33SemiBoldWhite,
        ),
        const SizedBox(height: 8),
        Text(
          'Start shopping the latest tech and accessories today.',
          style: AppTextStyles.font15w400Grey.copyWith(
            color: AppColors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}