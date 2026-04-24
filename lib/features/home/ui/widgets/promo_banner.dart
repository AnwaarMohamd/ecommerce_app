import 'package:ecommerce_app/core/constants/app_assets.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CYBER\nLINIO",
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    Text(
                      "40%",
                      style: AppTextStyles.font25SemiBoldWhite.copyWith(
                        height: 0.2,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text("DSCNT", style: AppTextStyles.discount),
                  ],
                ),
    
                const Gap(6),
                Text(
                  "in technology",
                  style: AppTextStyles.font18w400White.copyWith(height: 0.2),
                ),
                const Gap(13),
    
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "FREE SHIPPING",
                    style: TextStyle(
                      color: AppColors.orangeDark,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 90,
            bottom: 30,
            child: Image.asset(AppAssets.whiteZoom, height: 150),
          ),
    
          Positioned(
            right: 20,
            bottom: 0,
            child: Image.asset(AppAssets.switchDevice, height: 150),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(AppAssets.airpods, height: 100),
          ),

          
        ],
      ),
  
    );
  }
}
