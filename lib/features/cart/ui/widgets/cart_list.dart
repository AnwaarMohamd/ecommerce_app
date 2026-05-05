// list of cart items
import 'package:ecommerce_app/features/cart/ui/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  final List items;

  const CartList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartItemCard(item: items[index]);
      },
    );
  }
}