import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/features/cart/data/cart_item.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_item_info.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// main card
class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          ProductImage(image: item.image),
          const Gap(14),
          Expanded(child: CartItemInfo(item: item)),
        ],
      ),
    );
  }
}