// item details
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/features/cart/data/cart_item.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/delete_button.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';

class CartItemInfo extends StatelessWidget {
  final CartItem item;

  const CartItemInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(item.name, style: AppTextStyles.itemTitle),
            ),
            DeleteButton(itemId: item.id),
          ],
        ),
        Text('\$${item.price}', style: AppTextStyles.price),
        Row(
          children: [
            QuantityStepper(item: item),
            const Spacer(),
            Text('\$${item.lineTotal}'),
          ],
        ),
      ],
    );
  }
}