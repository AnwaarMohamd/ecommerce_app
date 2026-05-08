import 'package:image_picker/image_picker.dart';
import 'package:ecommerce_app/core/services/firestore_service.dart';
import 'package:ecommerce_app/core/services/firebase_storage_service.dart';
import '../models/product_model.dart';

class AddProductRepository {
  final FirestoreService firestoreService;
  final FirebaseStorageService storageService;

  AddProductRepository(
    this.firestoreService,
    this.storageService,
  );

  Future<String> uploadProductImage(
    String productId,
    XFile image,
    void Function(double) onProgress,
  ) async {
    return storageService.uploadProductImage(image, productId, onProgress);
  }

  Future<void> addProduct(ProductModel product) async {
    await firestoreService.addProduct(product);
  }
}
