import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesChips extends StatelessWidget {
  const CategoriesChips({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ["Technology", "Fashion", "Sports", "Supermarket"];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Chip(label: Text(categories[index]) , backgroundColor: AppColors.white , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          );
        },
      ),
    );
  }
}
