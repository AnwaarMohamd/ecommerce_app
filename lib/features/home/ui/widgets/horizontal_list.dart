import 'package:flutter/material.dart';
import 'product_card.dart';

class HorizontalList extends StatelessWidget {
  final List<Map<String, String>> products;

  const HorizontalList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ProductCard(
            title: product['title']!,
            price: product['price']!,
            image: product['image']!,
          );
        },
      ),
    );
  }
}
