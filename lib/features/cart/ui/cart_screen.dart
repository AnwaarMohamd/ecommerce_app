import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_body.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.primaryDark,
      body: const CartBody(),
    );
  }
}