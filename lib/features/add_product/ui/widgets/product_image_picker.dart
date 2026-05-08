import 'dart:typed_data';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductImagePicker extends StatelessWidget {
  final Uint8List? selectedImageBytes;
  final bool isPicking;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  const ProductImagePicker({
    super.key,
    required this.selectedImageBytes,
    required this.onPickImage,
    required this.onRemoveImage,
    this.isPicking = false,
  });

  void _openPreview(BuildContext context) {
    if (selectedImageBytes == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _ImagePreviewPage(imageBytes: selectedImageBytes!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = selectedImageBytes != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Product image', style: AppTextStyles.font24w400White),
        const Gap(16),
        GestureDetector(
          onTap: hasImage ? () => _openPreview(context) : onPickImage,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            height: 230,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.gradientTop, AppColors.gradientBottom],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gradientBottom.withAlpha(64),
                  blurRadius: 24,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (hasImage) ...[
                    Hero(
                      tag: 'add-product-image',
                      child: Image.memory(
                        selectedImageBytes!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryDark.withAlpha(89),
                            AppColors.primaryDark.withAlpha(31),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withAlpha(140),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        color: AppColors.white,
                        size: 56,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Text(
                          'Tap to select a premium product image',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subtitle13,
                        ),
                      ),
                    ),
                  ],
                  if (isPicking)
                    Container(
                      color: Colors.black45,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const Gap(14),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: hasImage ? 'Change photo' : 'Pick image',
                onPressed: onPickImage,
                backgroundColor: AppColors.gradientTop,
                textColor: AppColors.white,
              ),
            ),
            if (hasImage) ...[
              const Gap(12),
              SizedBox(
                height: 55,
                width: 55,
                child: ElevatedButton(
                  onPressed: onRemoveImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: AppColors.orange),
                    ),
                    elevation: 5,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ImagePreviewPage extends StatelessWidget {
  final Uint8List imageBytes;

  const _ImagePreviewPage({required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: 'add-product-image',
          child: Image.memory(imageBytes, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
