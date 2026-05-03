import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/core/widgets/app_header.dart';
import 'package:ecommerce_app/core/widgets/app_text_form_field.dart';
import 'package:ecommerce_app/features/login/ui/widgets/login_footer.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      debugPrint('Email: ${_emailController.text}');
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppHeader(
              title: 'Login',
              padding: const EdgeInsets.only(bottom: 10),
            ),
            const SizedBox(height: 20),

            AppTextFormField(
              hintText: 'Email',
              isEmailField: true,
              controller: _emailController,
            ),

            const SizedBox(height: 20),

            AppTextFormField(
              hintText: 'Password',
              isObscureText: isPasswordHidden,
              controller: _passwordController,
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
              ),
            ),

            const SizedBox(height: 32),

            AppButton(
              text: 'Sign In',
              backgroundColor: AppColors.secondary,
              textColor: AppColors.white,
              onPressed: () => _login(context),
            ),

            const SizedBox(height: 20),

            const LoginFooter(),
          ],
        ),
      ),
    );
  }
}
