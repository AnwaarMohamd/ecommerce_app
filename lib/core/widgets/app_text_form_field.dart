import 'package:ecommerce_app/core/helpers/app_regex.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool floatingLabel;
  final bool isEmailField;
  final Function(String)? onChanged;

  const AppTextFormField({
    super.key,
    this.floatingLabel = false,
    this.backgroundColor,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyle,
    this.inputTextStyle,
    this.isObscureText,
    this.suffixIcon,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.validator, // ❌ مش required
    this.onChanged,
    this.isEmailField = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool? isEmailValid;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      onChanged: (value) {
        if (widget.isEmailField) {
          setState(() {
            isEmailValid = AppRegex.isEmailValid(value);
          });
        }
        widget.onChanged?.call(value);
      },

      decoration: InputDecoration(
        isDense: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        labelText: widget.floatingLabel ? widget.hintText : null,
        floatingLabelBehavior: widget.floatingLabel
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,

        /// Enabled Border
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey.withAlpha(153),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(18),
            ),

        /// Focused Border
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary.withAlpha(179),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(18),
            ),

        /// Error Border
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red, width: 1),
          borderRadius: BorderRadius.circular(18),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red, width: 1.5),
          borderRadius: BorderRadius.circular(18),
        ),

        /// Hint
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: AppColors.greyDark.withAlpha(179),
              fontSize: 14,
            ),

        hintText: widget.floatingLabel ? null : widget.hintText,

        /// Background
        filled: true,
        fillColor: widget.backgroundColor ?? AppColors.white,

        /// Email validation icon
        suffixIcon: widget.isEmailField
            ? (isEmailValid == true
                ? const Icon(Icons.check_circle, color: Colors.green)
                : isEmailValid == false
                    ? const Icon(Icons.cancel, color: Colors.red)
                    : null)
            : widget.suffixIcon,
      ),

      obscureText: widget.isObscureText ?? false,

      style: widget.inputTextStyle ?? AppTextStyles.font14w500Black,

      ///Validation
      validator: (value) {
        // default
        if (value == null || value.isEmpty) {
          return 'Please Enter ${widget.hintText}';
        }

        // email check
        if (widget.isEmailField && !AppRegex.isEmailValid(value)) {
          return 'Please Enter a valid email';
        }

        // custom validator
        return widget.validator?.call(value);
      },
    );
  }
}