// bottom checkout panel
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckoutPanel extends StatelessWidget {
  final double total;

  const CheckoutPanel({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Total', style: AppTextStyles.subtitle13),
              const Spacer(),
              Text('\$$total', style: AppTextStyles.total),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: total == 0 ? null : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
              ),
              child: const Text('Checkout', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}
