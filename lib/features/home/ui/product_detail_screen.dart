import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final String description;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.gradientTop, AppColors.gradientBottom],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: AppColors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const Icon(Icons.favorite_border, color: AppColors.white),
                            ],
                          ),
                          const Gap(14),
                          Hero(
                            tag: title,
                            child: Image.asset(
                              image,
                              height: 240,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Gap(16),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.font33SemiBoldWhite,
                          ),
                          const Gap(8),
                          Text(
                            price,
                            style: AppTextStyles.font24w400White.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Gap(12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.16),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Hot Deal',
                              style: AppTextStyles.font12w400White,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product overview', style: AppTextStyles.font30SemiBoldOrange.copyWith(fontSize: 20)),
                          const Gap(12),
                          Text(
                            description,
                            style: AppTextStyles.font14w500Black.copyWith(height: 1.6),
                          ),
                          const Gap(18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _InfoChip(label: 'Free delivery'),
                              _InfoChip(label: '1 year warranty'),
                              _InfoChip(label: 'Fast support'),
                            ],
                          ),
                          const Gap(24),
                          Text('Features', style: AppTextStyles.font30SemiBoldOrange.copyWith(fontSize: 20)),
                          const Gap(12),
                          const _FeatureText(text: 'High-performance CPU and graphics'),
                          const _FeatureText(text: 'Wireless connectivity and long battery life'),
                          const _FeatureText(text: 'Premium build, suitable for work and play'),
                          const Gap(24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: AppButton(
                text: 'Shop Now',
                backgroundColor: AppColors.gradientBottom,
                textColor: AppColors.white,
                onPressed: () async {
                  await context.read<CartProvider>().addProduct(
                        id: title,
                        name: title,
                        image: image,
                        price: double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0,
                      );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added to cart.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: AppTextStyles.font14PurpleMedium,
      ),
    );
  }
}

class _FeatureText extends StatelessWidget {
  final String text;

  const _FeatureText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.gradientBottom, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.font14w500Black,
            ),
          ),
        ],
      ),
    );
  }
}
