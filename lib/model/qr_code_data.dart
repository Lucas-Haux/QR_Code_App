import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_generator/model/inputs_data.dart';

String qrCodeImage = '';
ValueNotifier<String> qrCodeImageNotifier = ValueNotifier<String>('');

http.Response response = http.Response('', 200);

class QRCodeData {
  String constructQRCodeUrl() {
    String errorString = selectedErrorCorrectionLevel.toString().substring(21);
    String foregroundColor = currentForegroundColor.toString().substring(
          10, // remove first 10 characters
          currentForegroundColor.toString().length - 1, // remove last character
        );
    String backgroundColor = currentBackgroundColor.toString().substring(
          10, // remove first 10 characters
          currentBackgroundColor.toString().length - 1, // remove last character
        );

    return 'https://image-charts.com/chart?chl=${inputString().toString()}&choe=UTF-8&chs=200x200&cht=qr&chld=$errorString|0&icqrf=$foregroundColor&icqrb=$backgroundColor';
  }

  Future<void> fetchQRCode(BuildContext context) async {
    String activeUrl = constructQRCodeUrl();

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Make Api called
    try {
      // Make the API Call
      response = await http.get(Uri.parse(activeUrl));

      if (response.statusCode == 200) {
        qrCodeImageNotifier.value = activeUrl.replaceAll(' ', '%20');
        qrCodeImage = activeUrl.replaceAll(' ', '%20');
      } else {
        print('qrcode fetch failed: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle different types of errors and display an appropriate message
      String errorMessage;

      if (error is FormatException) {
        errorMessage = 'Invalid QR code format. Please check your input.';
      } else if (error is SignalException) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else {
        errorMessage = 'An unexpected error occurred: $error';
      }

      // Show errorMessage in SnackBar
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }
}
