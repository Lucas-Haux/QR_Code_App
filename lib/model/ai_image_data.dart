import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_code_generator/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:qr_code_generator/model/ai_json_encode.dart';

String aiImage = '';
http.Response aiImageResponse = http.Response('', 200);
ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

Future<void> generateAiImage() async {
  isLoadingNotifier.value = true;
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

    List<String> imageUrls =
        List<String>.from(result['output']['output_images']);

    aiImage = imageUrls[0];
  } else {
    var result = json.decode(response.body);

    // Step 2: Extract the inner JSON string from the "error" field
    String innerJsonString = result['error'].split(' - ')[1];

    var innerJson = json.decode(innerJsonString);

    String errorMessage = innerJson['detail']['error'];

    if (errorMessage == 'No QR code found in image') {
      SnackBarManager.showSnackBar(
        'Error',
        'Provided QR Code is not acceptable. Often caused by hard to read colors.',
        ContentType.failure,
      );
    } else if (errorMessage ==
        'AssertionError: safety_checker: at least one of text, image is required') {
      SnackBarManager.showSnackBar(
        'Error',
        'To Generate AI QR Code you must provide a text prompt or an image prompt',
        ContentType.failure,
      );
    } else if (errorMessage.contains('<p>')) {
      SnackBarManager.showSnackBar(
        'Crtical Error!!!!',
        'Sorry, a major problem on our end. Cant generate AI QR Codes right now.',
        ContentType.failure,
      );
    } else {
      SnackBarManager.showSnackBar(
        'Error',
        errorMessage,
        ContentType.failure,
      );
    }
  }
  isLoadingNotifier.value = false;
  aiImageResponse = await http.get(Uri.parse(aiImage));
}
