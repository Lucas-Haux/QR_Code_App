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
  // Controllers
  final inputTextController = TextEditingController();
  final inputDataLoss = MenuController();

  //QR Code Data
  String qrCodeImage = '';
  http.Response response = http.Response('', 200);

  // Default State variables
  bool isLinkMessageActive = false;

  //foregroundColor
  Color pickerForgroundColor = const Color(0x9E9E9E9E);
  Color currentForgroundColor = const Color(0x9E9E9E9E);
  void onForgroundColorChanged(Color color) {
    setState(() {
      currentForgroundColor = color;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
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
    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.pop(context);
    });
  }

  // Method to know when the message field is set to link
  void onLinkMessageActiveChanged(bool isActive) {
    setState(() {
      isLinkMessageActive = isActive;
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

    // If link message is active, prepend the link type to the input text
    if (isLinkMessageActive == true && selectedLinkType != LinkType.raw) {
      inputString = selectedLinkType.toString().substring(9) +
          '://' +
          inputTextController.text;
    }

    // Construct the QR Code API URL
    final String qrCodeUrl =
        'https://image-charts.com/chart?chl=$inputString&choe=UTF-8&chs=200x200&cht=qr&chld=$errorString|0&icqrf=$forgroundColor&icqrb=$backgroundColor';

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
            //QR code Input Fields
            InputSection(
              inputTextController: inputTextController,
              currentForgroundColor: currentForgroundColor,
              currentBackgroundColor: currentBackgroundColor,
              pickerForgroundColor: pickerForgroundColor,
              pickerBackgroundColor: pickerBackgroundColor,
              onForgroundColorChanged: onForgroundColorChanged,
              onBackgroundColorChanged: onBackgroundColorChanged,
              isLinkMessageActive: isLinkMessageActive,
              onLinkMessageActiveChanged: onLinkMessageActiveChanged,
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
                    qrCodeImage.isNotEmpty
                        ? Column(
                            children: [
                              Image.network(qrCodeImage), // Display the QR code
                              const SizedBox(height: 16), // Space Bellow QR
                            ],
                          )
                        : const SizedBox.shrink(), // Show nothing if no QR code
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
                          const SizedBox(width: 20), // Add space if QR code
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
