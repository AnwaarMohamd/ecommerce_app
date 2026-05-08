import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AnimatedLoadingOverlay extends StatelessWidget {
  final double progress;

  const AnimatedLoadingOverlay({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 260),
      opacity: 1,
      child: Container(
        color: Colors.black.withAlpha(140),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withAlpha(235),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderWhite, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gradientBottom.withAlpha(102),
                  blurRadius: 36,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: CircularProgressIndicator(
                        value: progress > 0 ? progress : null,
                        strokeWidth: 8,
                        color: AppColors.orange,
                        backgroundColor: AppColors.white.withAlpha(31),
                      ),
                    ),
                    const Icon(Icons.cloud_upload, size: 36, color: AppColors.white),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Uploading product',
                  style: AppTextStyles.font16greyregular.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(progress * 100).clamp(0, 100).toStringAsFixed(0)}% completed',
                  style: AppTextStyles.font14w500Black.copyWith(color: AppColors.white70),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress > 0 ? progress : null,
                  color: AppColors.gradientTop,
                  backgroundColor: AppColors.white.withAlpha(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
