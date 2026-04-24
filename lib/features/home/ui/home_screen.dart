import 'package:ecommerce_app/core/constants/app_assets.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'widgets/home_header.dart';
import 'widgets/promo_banner.dart';
import 'widgets/categories_chips.dart';
import 'widgets/section_title.dart';
import 'widgets/horizontal_list.dart';
import 'widgets/custom_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final hotSales = [
    {"title": "MacBook Pro 16", "price": "\$999", "image": AppAssets.macbook},
    {
      "title": "Sony WH-1000XM4",
      "price": "\$4,999",
      "image": AppAssets.headSet,
    },
    {"title": "AirPods Pro", "price": "\$1,999", "image": AppAssets.redAirPods},
  ];

  final recentlyViewed = [
    {"title": "AirPods Pro", "price": "\$1,999", "image": AppAssets.redAirPods},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(),

      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const HomeHeader(),
                const Gap(20),

                const PromoBanner(),
                const Gap(5),

                Center(
                  child: Text(
                    "Valid from 27/03 to 01/04 2022. Min stock: 1 unit",
                    style: AppTextStyles.font12w400Grey,
                  ),
                ),
                const Gap(10),
                const CategoriesChips(),
                const Gap(20),
                const SectionTitle(title: "Hot sales"),
                const Gap(5),
                HorizontalList(products: hotSales),
                const Gap(25),
                const SectionTitle(title: "Recently viewed"),
                const Gap(5),
                HorizontalList(products: recentlyViewed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
