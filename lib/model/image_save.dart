import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:qr_code_generator/main.dart';

Future<void> saveImage(BuildContext context, response) async {
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
        SnackBarManager.showSnackBar(
          'Success',
          'Image Saved to "${file.path}"',
          ContentType.success,
        );
      }
    }

    // Errors
  } catch (e) {
    SnackBarManager.showSnackBar(
      'Error',
      '$e',
      ContentType.failure,
    );
  }
}
