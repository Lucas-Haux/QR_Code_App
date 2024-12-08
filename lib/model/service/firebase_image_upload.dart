import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

class FirebaseImageUpload {
  Future<String> uploadImage(File imageFile) async {
    try {
      final fileName = basename(imageFile.path); // Define your file name

      final reference = FirebaseStorage.instance.ref('images/$fileName');

      // Upload the file
      await reference.putFile(imageFile).whenComplete(() async {
        // Get the download URL after the upload is complete
        String downloadURL = await reference.getDownloadURL();
        print("Image uploaded successfully. Download URL: $downloadURL");

        return downloadURL;
      });
    } catch (e) {
      throw "error: $e";
    }
    throw "error";
  }
}
