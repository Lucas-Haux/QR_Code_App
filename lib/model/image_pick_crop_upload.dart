import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/ai_image_data.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:qr_code_generator/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

File? image;

ValueNotifier<File?> referenceImageNotifier = ValueNotifier<File?>(null);

Future pickImage() async {
  try {
    final chosenImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (chosenImage == null) return;
    image = File(chosenImage.path);
  } catch (e) {
    SnackBarManager.showSnackBar(
      'Error',
      '$e',
      ContentType.failure,
    );
  }
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: image!.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    compressQuality: 100, // Optional: set compression quality if needed
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
  );
  File finalImage = File(croppedFile!.path);
  referenceImageNotifier.value = image;

  await uploadImage(finalImage);
}

// Function to upload the image to Firebase Storage
Future<void> uploadImage(File imageFile) async {
  try {
    final fileName = basename(image!.path); // Define your file name

    final reference = FirebaseStorage.instance.ref('images/$fileName');

    // Upload the file
    await reference.putFile(imageFile).whenComplete(() async {
      // Get the download URL after the upload is complete
      String downloadURL = await reference.getDownloadURL();
      imagePrompt = downloadURL;
      print("Image uploaded successfully. Download URL: $downloadURL");
    });
  } catch (e) {
    SnackBarManager.showSnackBar(
      'Error',
      '$e',
      ContentType.failure,
    );
  }
}
