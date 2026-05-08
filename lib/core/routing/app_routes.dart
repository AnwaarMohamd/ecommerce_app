import 'package:ecommerce_app/core/services/firestore_service.dart';
import 'package:ecommerce_app/core/services/firebase_storage_service.dart';
import 'package:ecommerce_app/features/add_product/data/repo/add_product_repo.dart';
import 'package:ecommerce_app/features/add_product/logic/cubit/add_product_cubit.dart';
import 'package:ecommerce_app/features/add_product/ui/add_product_page.dart';
import 'package:ecommerce_app/features/home/data/product_model.dart';
import 'package:ecommerce_app/features/home/ui/home_screen.dart';
import 'package:ecommerce_app/features/home/ui/product_detail_screen.dart';
import 'package:ecommerce_app/features/login/ui/login_screen.dart';
import 'package:ecommerce_app/features/onBoarding/ui/onboarding_screen.dart';
import 'package:ecommerce_app/features/signUp/ui/sign_up_screen.dart';
import 'package:ecommerce_app/features/cart/ui/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      case AppRoutes.addProduct:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AddProductCubit(
              AddProductRepository(
                FirestoreService(),
                FirebaseStorageService(),
              ),
            ),
            child: const AddProductPage(),
          ),
        );
    }

    return null;
  }
}

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String productDetails = '/product-details';
  static const String addProduct = '/add-product';
}
