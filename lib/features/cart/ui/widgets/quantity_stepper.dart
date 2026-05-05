// increment decrement
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/features/cart/data/cart_item.dart';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityStepper extends StatelessWidget {
  final CartItem item;

  const QuantityStepper({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StepperButton(
          icon: Icons.remove,
          onTap: () => context.read<CartProvider>().decrementQuantity(item.id),
        ),
       
        Text('${item.quantity}', style: AppTextStyles.quantity),
        StepperButton(
          icon: Icons.add,
          onTap: () => context.read<CartProvider>().incrementQuantity(item.id),
        ),
      ],
    );
  }
}
