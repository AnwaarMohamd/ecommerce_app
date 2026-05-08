import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductFormSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final void Function(String)? onNameChanged;
  final void Function(String)? onDescriptionChanged;
  final void Function(String)? onPriceChanged;

  const ProductFormSection({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    this.onNameChanged,
    this.onDescriptionChanged,
    this.onPriceChanged,
  });

  @override
  State<ProductFormSection> createState() => _ProductFormSectionState();
}

class _ProductFormSectionState extends State<ProductFormSection> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() => setState(() {}));
    _descriptionFocus.addListener(() => setState(() {}));
    _priceFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  Widget _buildField({
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    final bool isFocused = focusNode.hasFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isFocused ? AppColors.gradientTop : AppColors.borderWhite,
          width: isFocused ? 1.6 : 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientBottom.withAlpha(isFocused ? 46 : 20),
            blurRadius: isFocused ? 24 : 16,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: AppTextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        hintText: hint,
        backgroundColor: AppColors.primaryDark.withAlpha(20),
        inputTextStyle: AppTextStyles.font14w500Black.copyWith(color: AppColors.white),
        hintStyle: TextStyle(color: AppColors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: AppColors.borderWhite,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: AppColors.gradientBottom,
            width: 1.8,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Product details', style: AppTextStyles.font24w400White),
        const Gap(16),
        _buildField(
          hint: 'Product name',
          controller: widget.nameController,
          focusNode: _nameFocus,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: widget.onNameChanged,
        ),
        const Gap(18),
        _buildField(
          hint: 'Product description',
          controller: widget.descriptionController,
          focusNode: _descriptionFocus,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 4,
          onChanged: widget.onDescriptionChanged,
        ),
        const Gap(18),
        _buildField(
          hint: 'Price',
          controller: widget.priceController,
          focusNode: _priceFocus,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          onChanged: widget.onPriceChanged,
        ),
      ],
    );
  }
}
