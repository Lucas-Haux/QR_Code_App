import 'package:http/http.dart' as http;
import 'dart:convert';

class AiApiService {
  Future<http.Response> fetchAi(String aiParameters) async {
    //   isLoadingNotifier.value = true;

    final url = Uri.parse(
        "https://us-central1-qr-code-generator-a667f.cloudfunctions.net/generateQRCodeImage");
    print(url);
    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: aiParameters,
      );

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("QR Code Generated: $result");

        return response;
      } else {
        var result = json.decode(response.body);

        // Step 2: Extract the inner JSON string from the "error" field
        String innerJsonString = result['error'].split(' - ')[1];

        var innerJson = json.decode(innerJsonString);

        String errorMessage = innerJson['detail']['error'];
        throw errorMessage;
      }
    } catch (e) {
      print('couldnt fetch ai image: $e');
      throw 'couldnt fetch ai image: $e';
    }
  }
}
