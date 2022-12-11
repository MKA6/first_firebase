import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StoragHelper {
  StoragHelper._();

  static StoragHelper storagHelper = StoragHelper._();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage(String folderName ,File file) async {
    String path = file.path;
    String name = path.split('/').last; // رح يجيب اخر عنصر في الاري وهو اسم الصورة 1
    // String flieName = DateTime.now().toString(); // or
    Reference reference = storage.ref('prifile_images/$name');
    await reference.putFile(file); // ابدا ارفع الملف الى انا حددته  2
    String imageUrl =
        await reference.getDownloadURL(); // جيب اللنك تاع هذه الصورة 3
    return imageUrl;
  }
}
