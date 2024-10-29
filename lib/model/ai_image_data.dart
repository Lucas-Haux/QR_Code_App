import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_code_generator/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:qr_code_generator/model/ai_json_encode.dart';

String aiImage = '';
ValueNotifier<String> aiNotifier = ValueNotifier<String>('');
http.Response aiImageResponse = http.Response('', 200);

TextEditingController prompt = TextEditingController();
TextEditingController negativePrompt = TextEditingController();
String imagePrompt = "";

double brightnessValue = 0.3;
double tilingValue = 0.3;
double guidanceValue = 9;
double qrScaleValue = 0.9;
double imageStrengthValue = 0.3;

Future<void> generateAiImage() async {
  aiNotifier.value =
      'https://kagi.com/proxy/loading-gif.gif?c=SL-LVC2RnE1nrizWRL3dvwb36tRbmAFYeUeqSXmQ5wMJ8mdxzHdLAHGZaApxAZHAUuBN1GoGuTraS-0ZHD_c6N4pf3GhJ42iVFfihEvou5o%3D'; // loading gif needs to be change
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

    print(errorMessage); // This will print: "No QR code found in image"

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
    } else {
      SnackBarManager.showSnackBar(
        'Error',
        errorMessage,
        ContentType.failure,
      );
    }
  }
  aiNotifier.value = aiImage;
  aiImageResponse = await http.get(Uri.parse(aiImage));
}
