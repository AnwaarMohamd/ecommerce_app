import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoriesChips extends StatelessWidget {
  final int selectedIndex;
  final List<String> categories;
  final ValueChanged<int> onCategorySelected;

  const CategoriesChips({
    super.key,
    required this.selectedIndex,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onCategorySelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.gradientBottom
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.gradientBottom
                        : AppColors.grey,
                    width: 1,
                  ),
                ),
                child: Text(
                  categories[index],
                  style: isSelected
                      ? AppTextStyles.font14w500Black.copyWith(
                          color: AppColors.white,
                        )
                      : AppTextStyles.font14w500Black.copyWith(
                          color: AppColors.greyDark,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
