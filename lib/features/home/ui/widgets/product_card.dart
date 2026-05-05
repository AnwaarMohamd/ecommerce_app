import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:ecommerce_app/features/home/data/product_model.dart';
import 'package:ecommerce_app/features/home/ui/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool showDetails;

  const ProductCard({
    super.key,
    required this.product,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Badge
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gradientBottom.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  showDetails ? 'HOT' : 'NEW',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gradientBottom,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Image
            Center(
              child: Hero(
                tag: product.title,
                child: Image.asset(
                  product.image,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Title
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font14w500Black.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            /// Price
            Text(
              product.price,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.gradientBottom,
              ),
            ),

            const Spacer(),

            /// Button
            SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                onPressed: () {
                  if (showDetails) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, animation, __) => FadeTransition(
                          opacity: animation,
                          child: ProductDetailScreen(
                            title: product.title,
                            price: product.price,
                            image: product.image,
                            description: product.description,
                          ),
                        ),
                      ),
                    );
                    return;
                  }

                  context.read<CartProvider>().addProduct(
                    id: product.title,
                    name: product.title,
                    image: product.image,
                    price: _parsePrice(product.price),
                  );

                  Navigator.pushNamed(context, AppRoutes.cart);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gradientBottom,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  showDetails ? 'Details' : 'Add',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _parsePrice(String value) {
    final normalized = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(normalized) ?? 0;
  }
}
