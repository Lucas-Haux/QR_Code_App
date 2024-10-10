import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

Future<void> saveImage(BuildContext context, response) async {
  String? errorMessage;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    // Get temporary directory
    final dir = await getTemporaryDirectory();

    // Create an filename name
    var filename = '${dir.path}/image.png';

    //make bin file to png
    img.Image? decodedImage = img.decodeImage(response.bodyBytes);
    final file = File(filename);

    if (decodedImage != null) {
      final png = Uint8List.fromList(img.encodePng(decodedImage));
      await file.writeAsBytes(png); // save Image to file system

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        errorMessage = 'Image saved to disk';
      }
    }

    // Errors
  } catch (e) {
    errorMessage = 'An error occurred while saving the image Error: $e';
  }

  // Show error in stackbar
  if (errorMessage != null) {
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
