import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 50,
            decoration: BoxDecoration(
            
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              children: [
                Icon(Icons.search , color: AppColors.greyDark),
                Gap(8),
                Text("Search products" , style: TextStyle(color: AppColors.greyDark)),
              ],
            ),
          ),
        ),
        Gap(10),
        Stack(
          children: const [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.grey,
              child: Icon(Icons.notifications_outlined, color: AppColors.greyDark),
            ),
            Positioned(
              right: 2,
              top: 2,
              child: CircleAvatar(radius: 4, backgroundColor: AppColors.red),
            ),
          ],
        ),
      ],
    );
  }
}
