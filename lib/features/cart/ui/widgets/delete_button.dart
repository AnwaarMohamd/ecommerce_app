// delete item
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteButton extends StatelessWidget {
  final String itemId;

  const DeleteButton({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<CartProvider>().removeProduct(itemId);
      },
      icon: const Icon(Icons.delete, color: AppColors.danger),
    );
  }
}