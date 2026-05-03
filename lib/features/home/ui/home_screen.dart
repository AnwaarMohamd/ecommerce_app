import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/features/home/data/home_data.dart';
import 'package:ecommerce_app/features/home/ui/widgets/promo_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'widgets/home_header.dart';
import 'widgets/promo_banner.dart';
import 'widgets/categories_chips.dart';
import 'widgets/section_title.dart';
import 'widgets/horizontal_list.dart';
import 'widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: const CustomBottomNav(),
      extendBody: true,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradientTop, AppColors.gradientBottom],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: HomeHeader(),
              ),
            ),
          ),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    const PromoBanner(),
                    const Gap(18),
                    const PromoInfo(),
                    const Gap(18),

                    CategoriesChips(
                      selectedIndex: selectedCategoryIndex,
                      categories: HomeData.categories,
                      onCategorySelected: (index) {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                    ),

                    const Gap(24),

                    const SectionTitle(title: 'Hot sales'),
                    const Gap(12),
                    HorizontalList(
                      products: HomeData.hotSales,
                      showDetails: true,
                    ),

                    const Gap(28),

                    const SectionTitle(title: 'Recently viewed'),
                    const Gap(12),
                    HorizontalList(products: HomeData.recentlyViewed),

                    const Gap(70),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
