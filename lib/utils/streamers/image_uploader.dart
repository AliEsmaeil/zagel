import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final class ImageUploader {
  File image;
  ImageUploader({required this.image});

  Future<String> uploadImage({
    required String storagePath,
  }) async {
    Reference ref = FirebaseStorage.instance.ref(storagePath);

    ref = ref.child(Uri.file(image.path).pathSegments.last);
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}
