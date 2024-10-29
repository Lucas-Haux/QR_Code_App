import 'dart:convert';
import 'package:qr_code_generator/model/ai_json_encode.dart';
import 'package:http/http.dart' as http;

Future<void> generateQRCodeImage() async {
  final url = Uri.parse(
      "https://us-central1-qr-code-generator-a667f.cloudfunctions.net/generateQRCodeImage");

  http.Response response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: encodedBody(),
  );

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    print("QR Code Generated: $result");
  } else {
    var result = json.decode(response.body);

    print("Failed to generate QR code: ${result}");
  }
}
