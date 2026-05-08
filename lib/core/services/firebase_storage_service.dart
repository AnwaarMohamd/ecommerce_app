import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService([FirebaseStorage? storage])
      : _storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadProductImage(
    XFile image,
    String productId,
    void Function(double) onProgress,
  ) async {
    final bytes = await image.readAsBytes();
    final ref = _storage.ref().child('products/$productId.jpg');
    final metadata = SettableMetadata(contentType: 'image/jpeg');

    final uploadTask = ref.putData(bytes, metadata);
    uploadTask.snapshotEvents.listen((snapshot) {
      final progress = snapshot.totalBytes > 0
          ? snapshot.bytesTransferred / snapshot.totalBytes
          : 0.0;
      onProgress(progress);
    });

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
