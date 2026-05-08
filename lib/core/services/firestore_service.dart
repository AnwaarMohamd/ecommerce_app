import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/add_product/data/models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService([FirebaseFirestore? firestore])
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').doc(product.id).set(product.toJson());
  }
}
