import 'dart:async';
import 'dart:convert';
import 'package:qr_code_generator/model/service/ai_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

final aiUrlController = StreamController<String>.broadcast();
img.Image? aiImageFile;

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
}
