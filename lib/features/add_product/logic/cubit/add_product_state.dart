import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddProductState extends Equatable {
  final XFile? selectedImage;
  final Uint8List? selectedImageBytes;

  const AddProductState({this.selectedImage, this.selectedImageBytes});

  @override
  List<Object?> get props => [selectedImage?.path, selectedImageBytes?.length];
}

class AddProductInitial extends AddProductState {
  const AddProductInitial({super.selectedImage, super.selectedImageBytes});
}

class AddProductPickingImage extends AddProductState {
  const AddProductPickingImage({super.selectedImage, super.selectedImageBytes});
}

class AddProductUploading extends AddProductState {
  final double progress;

  const AddProductUploading({
    required this.progress,
    super.selectedImage,
    super.selectedImageBytes,
  });

  @override
  List<Object?> get props => [selectedImage?.path, selectedImageBytes?.length, progress];
}

class AddProductSuccess extends AddProductState {
  final String message;

  const AddProductSuccess(this.message) : super();

  @override
  List<Object?> get props => [message];
}

class AddProductFailure extends AddProductState {
  final String message;

  const AddProductFailure({
    required this.message,
    super.selectedImage,
    super.selectedImageBytes,
  });

  @override
  List<Object?> get props => [message, selectedImage?.path, selectedImageBytes?.length];
}
