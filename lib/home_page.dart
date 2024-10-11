import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:qr_code_app/image_save.dart';
import 'package:qr_code_app/qr_message.dart';
import 'package:qr_code_app/qrcode_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Controllers
  final inputTextController = TextEditingController();
  final secondaryInputTextController = TextEditingController();
  final inputDataLoss = MenuController();

  //QR Code Data
  String qrCodeImage = '';
  http.Response response = http.Response('', 200);

  //foregroundColor
  Color pickerForgroundColor = const Color(0x9E9E9E9E);
  Color currentForgroundColor = const Color(0x9E9E9E9E);
  void onForgroundColorChanged(Color color) {
    setState(() {
      currentForgroundColor = color;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pop(context);
    });
  }

  //backgroundColor
  Color pickerBackgroundColor = const Color(0xFFFFFFFF);
  Color currentBackgroundColor = const Color(0xFFFFFFFF);
  void onBackgroundColorChanged(Color color) {
    setState(() {
      currentBackgroundColor = color;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pop(context);
    });
  }

  //qrcode api call
  Future<void> _fetchQRCode() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    //Parameters
    String inputString = inputTextController.text;
    String errorString = selectedErrorCorrectionLevel.toString().substring(21);
    String forgroundColor = currentForgroundColor.toHexString().substring(2);
    String backgroundColor = currentBackgroundColor.toHexString().substring(2);

    switch (selectedMessageType) {
      case MessageType.text:
        inputString = inputTextController.text;
        break;
      case MessageType.link:
        if (selectedLinkType != LinkType.raw) {
          inputString =
              '${selectedLinkType.toString().substring(9)}://${inputTextController.text}';
        } else {
          inputString = inputTextController.text;
        }

        break;
      case MessageType.wifi:
        inputString =
            'WIFI:T:${selectedWifiType.toString().substring(9).toUpperCase()};S:${inputTextController.text};P:${secondaryInputTextController.text};;';
        break;
    }

    // Construct the QR Code API URL
    final String qrCodeUrl =
        'https://image-charts.com/chart?chl=$inputString&choe=UTF-8&chs=200x200&cht=qr&chld=$errorString|0&icqrf=$forgroundColor&icqrb=$backgroundColor';
    print(qrCodeUrl);

    try {
      // Make the API Call
      response = await http.get(Uri.parse(qrCodeUrl));

      if (response.statusCode == 200) {
        setState(() {
          qrCodeImage = qrCodeUrl;
        });
      } else {
        // Handle HTTP error response
        throw Exception(
            'Failed to generate QR code. Status code: ${response.statusCode}');
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

      if (inputString.isEmpty) {
        errorMessage = 'Error: No Message Provided, cant make QR Code';
      }

      // Show errorMessage in SnackBar
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMessage)));
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
            // Input Fields for the QRcode Message
            MessageField(
              inputTextController: inputTextController,
              secondaryInputTextController: secondaryInputTextController,
            ),

            //QR code Input Fields
            InputSection(
              currentForgroundColor: currentForgroundColor,
              currentBackgroundColor: currentBackgroundColor,
              pickerForgroundColor: pickerForgroundColor,
              pickerBackgroundColor: pickerBackgroundColor,
              onForgroundColorChanged: onForgroundColorChanged,
              onBackgroundColorChanged: onBackgroundColorChanged,
            ),
            // Display QR Code and buttons
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
                  children: [
                    SizedBox(
                      child: qrCodeImage.isNotEmpty
                          ? Column(
                              children: [
                                Image.network(
                                  qrCodeImage, // Display the QR code
                                  scale: 2,
                                ),
                                const SizedBox(height: 16), // Space Bellow QR
                              ],
                            )
                          : const SizedBox
                              .shrink(), // Show nothing if no QR code
                    ),
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
                          const SizedBox(width: 10), // Add space if QR code
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
