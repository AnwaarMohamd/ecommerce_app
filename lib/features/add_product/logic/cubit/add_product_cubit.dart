import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce_app/features/add_product/data/models/product_model.dart';
import 'package:ecommerce_app/features/add_product/data/repo/add_product_repo.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final AddProductRepository repository;
  final ImagePicker _picker = ImagePicker();

  AddProductCubit(this.repository) : super(const AddProductInitial());

  XFile? get _selectedImage {
    final state = this.state;
    if (state is AddProductInitial) return state.selectedImage;
    if (state is AddProductPickingImage) return state.selectedImage;
    if (state is AddProductUploading) return state.selectedImage;
    if (state is AddProductFailure) return state.selectedImage;
    return null;
  }

  Uint8List? get _selectedImageBytes {
    final state = this.state;
    if (state is AddProductInitial) return state.selectedImageBytes;
    if (state is AddProductPickingImage) return state.selectedImageBytes;
    if (state is AddProductUploading) return state.selectedImageBytes;
    if (state is AddProductFailure) return state.selectedImageBytes;
    return null;
  }

  Future<void> pickImage() async {
    emit(AddProductPickingImage(
      selectedImage: _selectedImage,
      selectedImageBytes: _selectedImageBytes,
    ));

    try {
      final XFile? pickedPhoto = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (pickedPhoto == null) {
        emit(AddProductInitial(
          selectedImage: _selectedImage,
          selectedImageBytes: _selectedImageBytes,
        ));
        return;
      }

      final bytes = await pickedPhoto.readAsBytes();
      emit(AddProductInitial(
        selectedImage: pickedPhoto,
        selectedImageBytes: bytes,
      ));
    } on Exception catch (_) {
      emit(AddProductFailure(
        message: 'Unable to open gallery. Please try again.',
        selectedImage: _selectedImage,
        selectedImageBytes: _selectedImageBytes,
      ));
    }
  }

  void removeImage() {
    emit(const AddProductInitial());
  }

  Future<void> submitProduct({
    required String name,
    required String description,
    required String priceText,
  }) async {
    final image = _selectedImage;
    if (image == null) {
      emit(AddProductFailure(
          message: 'Please choose a product image before uploading.'));
      return;
    }

    final price = double.tryParse(priceText.replaceAll(',', '.'));
    if (price == null || price <= 0) {
      emit(AddProductFailure(
        message: 'Please enter a valid price value.',
        selectedImage: _selectedImage,
        selectedImageBytes: _selectedImageBytes,
      ));
      return;
    }

    final productId = DateTime.now().millisecondsSinceEpoch.toString();
    emit(AddProductUploading(
      progress: 0.0,
      selectedImage: image,
      selectedImageBytes: _selectedImageBytes,
    ));

    try {
      final imageUrl = await repository.uploadProductImage(
        productId,
        image,
        (progress) {
          emit(AddProductUploading(
            progress: progress,
            selectedImage: image,
            selectedImageBytes: _selectedImageBytes,
          ));
        },
      );

      final product = ProductModel(
        id: productId,
        name: name.trim(),
        description: description.trim(),
        price: price,
        imageUrl: imageUrl,
      );

      await repository.addProduct(product);
      emit(const AddProductSuccess('Product added successfully'));
    } on FirebaseException catch (exception) {
      emit(AddProductFailure(
        message: exception.message ?? 'Upload failed. Please try again.',
        selectedImage: image,
        selectedImageBytes: _selectedImageBytes,
      ));
    } catch (error) {
      emit(AddProductFailure(
        message: 'Unable to save product. Please try again later.',
        selectedImage: image,
        selectedImageBytes: _selectedImageBytes,
      ));
    }
  }
}
