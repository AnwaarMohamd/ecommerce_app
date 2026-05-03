import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/core/widgets/app_header.dart';
import 'package:ecommerce_app/core/widgets/app_text_form_field.dart';
import 'package:ecommerce_app/features/signUp/ui/widgets/sign_up_footer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      debugPrint('UserName: ${_usernameController.text}');
      debugPrint('Email: ${_emailController.text}');
      debugPrint('Password: ${_passwordController.text}');

      Navigator.pushNamed(context, AppRoutes.login);
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
              title: 'Create Account',
              padding: const EdgeInsets.only(bottom: 10),
            ),

            Gap(20),

            AppTextFormField(
              hintText: 'Username',
              controller: _usernameController,
            ),

            Gap(20),

            AppTextFormField(
              hintText: 'Email',
              isEmailField: true,
              controller: _emailController,
            ),

            Gap(20),

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

            Gap(32),

            AppButton(
              text: 'Sign Up',
              backgroundColor: AppColors.secondary,
              textColor: AppColors.white,
              onPressed: () => _signUp(context),
            ),

            Gap(20),

            const SignUpFooter(),
          ],
        ),
      ),
    );
  }
}
