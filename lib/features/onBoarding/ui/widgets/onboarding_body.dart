import 'package:ecommerce_app/core/constants/app_assets.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientTop, AppColors.gradientBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(60),

              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CYBER\nLINIO",
                          style: AppTextStyles.font50BoldOrange.copyWith(
                            height: 1.1,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Text(
                              "40%",
                              style: AppTextStyles.font33SemiBoldWhite.copyWith(
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text("DSCNT", style: AppTextStyles.discount),
                          ],
                        ),
                      ],
                    ),

                    /// ⚡ lightning (يمين)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Image.asset(AppAssets.lightning, height: 160),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Text(
                "in technology",
                style: AppTextStyles.font24w400White.copyWith(height: 0.2),
              ),

              Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "FREE SHIPPING",
                  style: TextStyle(
                    color: AppColors.orangeDark,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    ///Laptop
                    Positioned(
                      left: 0,
                      top: 5,
                      child: Image.asset(AppAssets.laptop, height: 140),
                    ),

                    ///Switch
                    Positioned(
                      right: 70,
                      top: 50,
                      child: Image.asset(AppAssets.switchDevice, height: 180),
                    ),

                    ///Headset
                    Positioned(
                      bottom: 130,
                      right: 30,
                      child: Image.asset(AppAssets.headSet, height: 180),
                    ),

                    ///Speaker
                    Positioned(
                      left: 0,
                      bottom: 30,
                      child: Image.asset(AppAssets.speaker, height: 70),
                    ),

                    ///AirPods
                    Positioned(
                      left: 0,
                      right: 60,
                      bottom: 0,
                      top: 230,
                      child: Center(
                        child: Image.asset(AppAssets.airpods, height: 120),
                      ),
                    ),

                    ///Zoom
                    Positioned(
                      left: 150,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(AppAssets.zoom, height: 100),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(50),

              /// FOOTER TEXT
              Center(
                child: Text(
                  "Valid from 27/03 to 01/04 2022. Min stock: 1 unit",
                  style: AppTextStyles.font12w400White,
                ),
              ),
              Gap(10),
              Column(
                children: [
                  AppButton(
                    text: "LOG IN",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  const Text("SKIP", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
