import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_code_app/image_save.dart';
import 'package:qr_code_app/qrcode_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final inputTextController = TextEditingController();
  final inputDataLoss = MenuController();
  String qrCodeImage = '';
  http.Response response = http.Response('', 200);

  Color pickerMainColor = const Color(0x9E9E9E9E);
  Color currentMainColor = const Color(0x9E9E9E9E);
  void onMainColorChanged(Color color) {
    setState(() {
      currentMainColor = color;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.pop(context);
    });
  }

  Color pickerBackgroundColor = const Color(0xFFFFFFFF);
  Color currentBackgroundColor = const Color(0xFFFFFFFF);
  void onBackgroundColorChanged(Color color) => setState(() {
        setState(() {
          currentBackgroundColor = color;
        });
        Navigator.pop(context);
      });

  //qrcode api call
  Future<void> _fetchQRCode() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String mainColor = currentMainColor.toHexString().substring(2);
    String backgroundColor = currentBackgroundColor.toHexString().substring(2);
    String inputString = inputTextController.text;
    String errorString = selectedErrorCorrectionLevel.toString().substring(21);

    final String qrCodeUrl =
        'https://image-charts.com/chart?chl=$inputString&choe=UTF-8&chs=200x200&cht=qr&chld=$errorString|0&icqrf=$mainColor&icqrb=$backgroundColor';

    try {
      response = await http.get(Uri.parse(qrCodeUrl));

      if (response.statusCode == 200) {
        setState(() {
          qrCodeImage = qrCodeUrl; // Update the state with the QR code URL
          print(qrCodeUrl);
        });
      } else {
        // If the server returns an error code
        throw Exception(
            'Failed to generate QR code. Status code: ${response.statusCode}');
      }
    } catch (error) {
      String message;

      if (error is FormatException) {
        message = 'Invalid QR code format. Please check your input.';
      } else if (error is SignalException) {
        message = 'Network error. Please check your internet connection.';
      } else {
        message = 'An unexpected error occurred: $error';
      }
      if (inputString.isEmpty) {
        message = 'Error: No Message Provided, cant make QR Code';
      }

      // Show error message in SnackBar
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputSection(
              inputTextController: inputTextController,
              currentMainColor: currentMainColor,
              currentBackgroundColor: currentBackgroundColor,
              pickerMainColor: pickerMainColor,
              pickerBackgroundColor: pickerBackgroundColor,
              onMainColorChanged: onMainColorChanged,
              onBackgroundColorChanged: onBackgroundColorChanged,
            ),
            Card(
              color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
              elevation: 1,
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  // QR Code
                  children: [
                    qrCodeImage.isNotEmpty
                        ? Column(
                            children: [
                              Image.network(qrCodeImage), // Display the QR code
                              const SizedBox(
                                  height:
                                      16), // Show SizedBox when QR code is fetched
                            ],
                          )
                        : const SizedBox
                            .shrink(), // Show nothing if no QR code is fetched
                    // Create QR Code Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: _fetchQRCode,
                          label: Text(qrCodeImage.isNotEmpty
                              ? 'Recreate QR Code'
                              : 'Create QR Code'),
                        ),
                        if (qrCodeImage.isNotEmpty) ...[
                          const SizedBox(
                              width:
                                  20), // Add space only if the QR code is not empty
                          FloatingActionButton(
                            onPressed: () {
                              saveImage(context, response);
                            },
                            child: const Icon(Icons.save),
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
