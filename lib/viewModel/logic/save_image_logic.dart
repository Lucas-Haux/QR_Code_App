import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:image/image.dart' as img;

Future<void> saveQrcodeImage(img.Image? imageFile) async {
  try {
    final tempDir = await getTemporaryDirectory();
    var file = File('${tempDir.path}/image.png');
    final png = Uint8List.fromList(img.encodePng(imageFile!));
    await file.writeAsBytes(png);

    final params = SaveFileDialogParams(sourceFilePath: file.path);
    final saveFile = await FlutterFileDialog.saveFile(params: params);

    if (saveFile != null) {
      print('saved successfully');
    }
  } catch (e) {
    throw 'couldnt save image $e';
  }
}
