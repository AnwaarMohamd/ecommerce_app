import 'dart:ui';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF080B1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF090D21),
              Color(0xFF16123B),
              Color(0xFF30115A),
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return Column(
                children: [
                  _CartHeader(itemCount: cartProvider.itemCount),
                  Expanded(
                    child: cartProvider.items.isEmpty
                        ? const _EmptyCart()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartProvider.items.length,
                            itemBuilder: (context, index) {
                              final item = cartProvider.items[index];
                              return CartItemCard(
                                key: ValueKey(item.id),
                                item: item,
                              );
                            },
                          ),
                  ),
                  _CheckoutPanel(total: cartProvider.totalPrice),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      child: Row(
        children: [
          _CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PPMori',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  child: Text(
                    '$itemCount selected item${itemCount == 1 ? '' : 's'}',
                    key: ValueKey(itemCount),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.62),
                      fontFamily: 'PPMori',
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _CircleIconButton(
            icon: Icons.shopping_bag_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _CheckoutPanel extends StatelessWidget {
  const _CheckoutPanel({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.18)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.24),
                blurRadius: 28,
                offset: const Offset(0, -12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'PPMori',
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 260),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      _formatPrice(total),
                      key: ValueKey(total),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'PPMori',
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: 1),
                duration: const Duration(milliseconds: 160),
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: total == 0 ? null : () {},
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.white.withOpacity(0.12),
                      backgroundColor: const Color(0xFFFFB84D),
                      foregroundColor: const Color(0xFF171127),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_outline_rounded, size: 20),
                        Gap(10),
                        Text(
                          'Checkout',
                          style: TextStyle(
                            fontFamily: 'PPMori',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.16)),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 42,
              ),
            ),
            const Gap(20),
            const Text(
              'Your cart is empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'PPMori',
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Gap(8),
            Text(
              'Add premium tech picks from the store and they will appear here instantly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.62),
                fontFamily: 'PPMori',
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.13)),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

String _formatPrice(double value) {
  final price = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  return '\$$price';
}
