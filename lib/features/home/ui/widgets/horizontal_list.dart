import 'package:ecommerce_app/features/home/data/product_model.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class HorizontalList extends StatelessWidget {
  final List<ProductModel> products;
  final bool showDetails;

  const HorizontalList({
    super.key,
    required this.products,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            showDetails: showDetails,
          );
        },
      ),
    );
  }
}