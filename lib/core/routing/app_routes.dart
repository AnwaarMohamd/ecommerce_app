import 'package:ecommerce_app/features/home/data/product_model.dart';
import 'package:ecommerce_app/features/home/ui/home_screen.dart';
import 'package:ecommerce_app/features/home/ui/product_detail_screen.dart';
import 'package:ecommerce_app/features/login/ui/login_screen.dart';
import 'package:ecommerce_app/features/onBoarding/ui/onboarding_screen.dart';
import 'package:ecommerce_app/features/signUp/ui/sign_up_screen.dart';
import 'package:ecommerce_app/features/cart/ui/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static String initialRoute() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return AppRoutes.home;
    }

    return AppRoutes.onboarding;
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case AppRoutes.productDetails:
        final product = settings.arguments as ProductModel?;
        if (product == null) {
          return MaterialPageRoute(builder: (_) => HomeScreen());
        }

        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            title: product.title,
            price: product.price,
            image: product.image,
            description: product.description,
          ),
        );
    }

    return null;
  }
}class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String productDetails = '/product-details';
}
