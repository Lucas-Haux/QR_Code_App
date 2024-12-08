import 'dart:async';
import 'dart:io';

import 'dart:convert';
import 'package:qr_code_generator/model/repository/ai_input_data.dart';
import 'package:qr_code_generator/model/service/ai_api_service.dart';
import 'package:qr_code_generator/model/service/firebase_image_upload.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:qr_code_generator/viewModel/ai_builder_viewmodel.dart';

final aiUrlController = StreamController<String>.broadcast();
img.Image? aiImageFile;

String referenceImage = "";

class AiDataRepository {
  Future<void> updateAi(String qrParamaters) async {
    print('getting ai image');
    try {
      http.Response response = await AiApiService().fetchAi(qrParamaters);
      var result = json.decode(response.body);
      List<String> imageUrls =
          List<String>.from(result['output']['output_images']);

      print('imageUrl: ${imageUrls[0]}');
      aiUrlController.add(imageUrls[0]);
      print('added soemthing to the controller');
    } catch (e) {
      print('failed to update ai image: $e');
      throw 'failed to update ai image: $e';
    }
  }

  Future<void> updateReferenceImage(File imageFile) async {
    try {
      String url = await FirebaseImageUpload().uploadImage(imageFile);
      imagePrompt = url;
      referenceImage = url;
    } catch (e) {
      throw 'error: e';
    }
  }
}
