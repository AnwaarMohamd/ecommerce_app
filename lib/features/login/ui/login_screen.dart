import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/features/login/ui/widgets/login_form.dart';
import 'package:ecommerce_app/features/login/ui/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientTop, AppColors.gradientBottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: const [
                  LoginHeader(),
                  Gap(40),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
