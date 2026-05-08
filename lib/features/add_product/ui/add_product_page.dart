import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/features/add_product/logic/cubit/add_product_cubit.dart';
import 'package:ecommerce_app/features/add_product/logic/cubit/add_product_state.dart';
import 'package:ecommerce_app/features/add_product/ui/widgets/animated_loading_overlay.dart';
import 'package:ecommerce_app/features/add_product/ui/widgets/product_form_section.dart';
import 'package:ecommerce_app/features/add_product/ui/widgets/product_image_picker.dart';
import 'package:ecommerce_app/features/add_product/ui/widgets/success_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool success = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: success ? AppColors.green : AppColors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          content: Text(
            message,
            style: AppTextStyles.font14w500Black.copyWith(color: AppColors.white),
          ),
        ),
      );
  }

  void _submitProduct() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AddProductCubit>().submitProduct(
          name: _nameController.text,
          description: _descriptionController.text,
          priceText: _priceController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: Text('Add Product', style: AppTextStyles.font24w400White),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.gradientTop.withAlpha(107), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.gradientBottom.withAlpha(92), Colors.transparent],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: BlocConsumer<AddProductCubit, AddProductState>(
              listener: (context, state) {
                if (state is AddProductFailure) {
                  _showSnackBar(state.message, success: false);
                }
                if (state is AddProductSuccess) {
                  _showSnackBar(state.message, success: true);
                  final navigator = Navigator.of(context);
                  Future.delayed(const Duration(milliseconds: 1200), () {
                    if (!mounted) return;
                    navigator.pop();
                  });
                }
              },
              builder: (context, state) {
                final isUploading = state is AddProductUploading;
                final imageBytes = state.selectedImageBytes;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Gap(16),
                      _BuildHeadline(),
                      const Gap(28),
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: AppColors.glassWhite,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: AppColors.borderWhite, width: 1.1),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gradientBottom.withAlpha(41),
                              blurRadius: 32,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProductImagePicker(
                                selectedImageBytes: imageBytes,
                                isPicking: state is AddProductPickingImage,
                                onPickImage: () => context.read<AddProductCubit>().pickImage(),
                                onRemoveImage: () => context.read<AddProductCubit>().removeImage(),
                              ),
                              const Gap(28),
                              ProductFormSection(
                                nameController: _nameController,
                                descriptionController: _descriptionController,
                                priceController: _priceController,
                              ),
                              const Gap(28),
                              AppButton(
                                text: isUploading ? 'Uploading...' : 'Add Product',
                                onPressed: isUploading ? () {} : _submitProduct,
                                backgroundColor: isUploading ? AppColors.grey : AppColors.gradientBottom,
                                textColor: AppColors.white,
                                enabled: !isUploading,
                              ),
                              const Gap(16),
                              Text(
                                'A beautifully crafted product upload flow with responsive feedback and premium micro-interactions.',
                                style: AppTextStyles.subtitle13,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(80),
                    ],
                  ),
                );
              },
            ),
          ),
          BlocBuilder<AddProductCubit, AddProductState>(
            builder: (context, state) {
              if (state is AddProductUploading) {
                return AnimatedLoadingOverlay(progress: state.progress);
              }
              if (state is AddProductSuccess) {
                return const SuccessAnimationWidget(message: 'Your product has been uploaded.');
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _BuildHeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Create new product', style: AppTextStyles.font33SemiBoldWhite),
        const Gap(10),
        Text(
          'Add a premium listing with glowing visuals, smart validation, and secure cloud upload.',
          style: AppTextStyles.subtitle13,
        ),
      ],
    );
  }
}
