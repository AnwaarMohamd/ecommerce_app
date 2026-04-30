import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/features/cart/logic/cart_provider.dart';
import 'package:ecommerce_app/features/cart/ui/cart_screen.dart';
import 'package:ecommerce_app/features/home/ui/home_screen.dart';
import 'package:ecommerce_app/features/login/ui/login_screen.dart';
import 'package:ecommerce_app/features/onBoarding/ui/onboarding_screen.dart';
import 'package:ecommerce_app/features/signUp/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cartProvider = CartProvider();
  await cartProvider.loadCart();

  runApp(MainApp(cartProvider: cartProvider));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.cartProvider});

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProvider,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.onboarding,
            routes: {
              AppRoutes.onboarding: (_) => const OnboardingScreen(),
              AppRoutes.login: (_) => const LoginScreen(),
              AppRoutes.signUp: (_) => const SignUpScreen(),
              AppRoutes.home: (_) => HomeScreen(),
              AppRoutes.cart: (_) => const CartScreen(),
            },
          );
        },
      ),
    );
  }
}
