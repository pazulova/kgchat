import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as fb_storage;

class FirebaseStorage {
  Future<String> uploadFile(String filePath, String fileName) async {
    File _file = File(filePath);

    log('filePath ==> $filePath');
    log('fileName ==> $fileName');

    try {
      final _uploadedFile = await fb_storage.FirebaseStorage.instance
          .ref('profile_images/$fileName')
          .putFile(_file);

      return await _uploadedFile.ref.getDownloadURL();
    } on fb_storage.FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}

final FirebaseStorage firebaseStorage = FirebaseStorage();
