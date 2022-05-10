import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class FirebaseStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> loadImage(XFile image) async {
    await storage.ref('images/${image.name}').putFile(File(image.path));
  }

  Future<String> getDownloadLinkUrl(String imageName) async {
    String downloadUrl =
        await storage.ref('images/$imageName').getDownloadURL();
    return downloadUrl;
  }
}
