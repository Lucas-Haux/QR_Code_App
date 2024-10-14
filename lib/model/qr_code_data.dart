import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_app/model/inputs_data.dart';

String qrCodeImage = '';
http.Response response = http.Response('', 200);

class QRCodeData {
  Future<void> fetchQRCode(
    BuildContext context,
  ) async {
    print(selectedMessageType);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String errorMessage = "";

    // Show errorMessage in SnackBar
    if (errorMessage.isNotEmpty) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  String constructQRCodeUrl() {
    String errorString = selectedErrorCorrectionLevel.toString().substring(21);
    String foregroundColor = currentForegroundColor
        .toString()
        .substring(10, currentForegroundColor.toString().length - 1);
    String backgroundColor = currentBackgroundColor
        .toString()
        .substring(10, currentBackgroundColor.toString().length - 1);

    return 'https://image-charts.com/chart?chl=${inputString().toString()}&choe=UTF-8&chs=200x200&cht=qr&chld=$errorString|0&icqrf=$foregroundColor&icqrb=$backgroundColor';
  }
}
