import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_generator/model/inputs_data.dart';
import 'package:qr_code_generator/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

bool qrCodeLoading = false;

String qrCodePrefName = 'Qr Code Size';
List<String> qrCodeSizeOptions = ['200x200', '400x400', '800x800', '999x999'];
String selectedQrCodeSize = '200x200';

String qrCodeImage = '';
ValueNotifier<String> qrCodeImageNotifier = ValueNotifier<String>('');

http.Response response = http.Response('', 200);

Color usedForgroundColor = currentForegroundColor;
Color usedBackgroundColor = currentBackgroundColor;
ErrorCorrectionLevel usedErrorCorrectionLevel = selectedErrorCorrectionLevel;

String constructQRCodeUrl() {
  String errorString = selectedErrorCorrectionLevel.toString().substring(21);

  String foregroundColor =
      '#${currentForegroundColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}'
          .substring(3);

  String backgroundColor =
      '#${currentBackgroundColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}'
          .substring(3);

  return 'https://image-charts.com/chart?chl=${inputString().toString()}&choe=UTF-8&chs=$selectedQrCodeSize&cht=qr&chld=$errorString|0&icqrf=$foregroundColor&icqrb=$backgroundColor';
}

Future<void> fetchQRCode(BuildContext context) async {
  qrCodeLoading = true;
  usedForgroundColor = currentForegroundColor;
  usedBackgroundColor = currentBackgroundColor;
  usedErrorCorrectionLevel = selectedErrorCorrectionLevel;

  String activeUrl = constructQRCodeUrl();
  print(activeUrl);

  // Make Api called
  try {
    // Make the API Call
    response = await http.get(Uri.parse(activeUrl));

    if (response.statusCode == 200) {
      qrCodeImageNotifier.value = activeUrl.replaceAll(' ', '%20');
      qrCodeImage = activeUrl.replaceAll(' ', '%20');
    } else {
      SnackBarManager.showSnackBar(
        'Error',
        '${response.reasonPhrase}',
        ContentType.failure,
      );
    }
  } catch (error) {
    SnackBarManager.showSnackBar(
      'Error',
      '$error',
      ContentType.failure,
    );
  }
}
