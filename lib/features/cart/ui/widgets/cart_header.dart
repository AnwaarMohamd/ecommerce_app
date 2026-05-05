// header with title and count
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/circle_icon_buttin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartHeader extends StatelessWidget {
  final int itemCount;

  const CartHeader({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Cart', style: AppTextStyles.title28),

                // animated count
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    '$itemCount items',
                    key: ValueKey(itemCount),
                    style: AppTextStyles.subtitle13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}