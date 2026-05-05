import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_header.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_list.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/checkout_panel.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // main container with gradient and provider
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cart, _) {
            return Column(
              children: [
                CartHeader(itemCount: cart.itemCount),
                Expanded(
                  child: cart.items.isEmpty
                      ? const EmptyCartWidget()
                      : CartList(items: cart.items),
                ),
                CheckoutPanel(total: cart.totalPrice),
              ],
            );
          },
        ),
      ),
    );
  }
}
