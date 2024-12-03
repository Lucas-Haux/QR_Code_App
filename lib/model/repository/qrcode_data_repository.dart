import 'dart:async';
import 'dart:typed_data';
import 'package:qr_code_generator/model/service/qrcode_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

final qrcodeUrlController = StreamController<String>.broadcast();
img.Image? qrcodeImageFile;
String qrcodeUrl = '';

class QrcodeDataRepository {
  Future<void> updateQrcode(String qrcodeParameters) async {
    try {
      http.Response response =
          await QrcodeApiService().fetchQrcode(qrcodeParameters);

      //image file
      Uint8List bytes = response.bodyBytes;
      qrcodeImageFile = img.decodeImage(bytes);

      //url
      String url = response.request!.url.toString(); // Ensure it's a valid URL
      qrcodeUrlController.add(url);
      qrcodeUrl = url;
    } catch (e) {
      throw 'couldnt update qrcode: $e';
    }
  }
}
