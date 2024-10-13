import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:qr_code_app/settings_page.dart';
import 'package:qr_code_app/ai_page.dart';
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
  final tertiaryInputTextController = TextEditingController();
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
    String errorMessage = "";

    //Parameters (do i need theses?)
    String inputString = inputTextController.text;
    String errorString = selectedErrorCorrectionLevel.toString().substring(21);
    String forgroundColor = currentForgroundColor.toHexString().substring(2);
    String backgroundColor = currentBackgroundColor.toHexString().substring(2);

    List<bool> checkInputs(TextEditingController firstInput,
        TextEditingController secondInput, TextEditingController thirdInput) {
      bool firstBool = firstInput.text.isNotEmpty;
      bool secondBool = secondInput.text.isNotEmpty;
      bool thirdBool = thirdInput.text.isNotEmpty;
      return [firstBool, secondBool, thirdBool]; // Return a list of booleans
    }

    List<bool> inputs = checkInputs(inputTextController,
        secondaryInputTextController, tertiaryInputTextController);

    bool inputsProvided = true;

    switch (selectedMessageType) {
      case MessageType.text:
        if (inputs[0]) {
          inputString = inputTextController.text;
        } else {
          errorMessage =
              'The Required Inputs Were Not Provided To make ${selectedMessageType.toString().substring(12).toUpperCase()} QR Code';
          inputsProvided = false;
        }

        break;
      case MessageType.link:
        if (inputs[0]) {
          if (selectedLinkType != LinkType.raw) {
            inputString =
                '${selectedLinkType.toString().substring(9)}://${inputTextController.text}';
          } else {
            inputString = inputTextController.text;
          }
        } else {
          errorMessage =
              'The Required Inputs Were Not Provided To make ${selectedMessageType.toString().substring(12).toUpperCase()} QR Code';
          inputsProvided = false;
        }
        break;
      case MessageType.wifi:
        if (inputs[0] && inputs[1]) {
          inputString =
              'WIFI:T:${selectedWifiType.toString().substring(9).toUpperCase()};S:${inputTextController.text};P:${secondaryInputTextController.text};;';
        } else {
          errorMessage =
              'The Required Inputs Were Not Provided To make ${selectedMessageType.toString().substring(12).toUpperCase()} QR Code';
          inputsProvided = false;
        }

        break;
      case MessageType.email:
        if (inputs[0]) {
          inputString = 'mailto:${inputTextController.text}';
          if (inputs[1]) {
            // do i need this cant the subject be there but empty?
            inputString += '?subject=${secondaryInputTextController.text}';
          }
        } else {
          errorMessage =
              'The Required Inputs Were Not Provided To make ${selectedMessageType.toString().substring(12).toUpperCase()} QR Code';
          inputsProvided = false;
        }
        break;
      case MessageType.contacts:
        if (inputs[0] && inputs[1] && inputs[2]) {
          inputString = '''
BEGIN:VCARD
VERSION:3.0
N:${inputTextController.text}
TEL:${secondaryInputTextController.text}
ADR:${tertiaryInputTextController.text}
END:VCARD
''';
        } else {
          errorMessage =
              'The Required Inputs Were Not Provided To make ${selectedMessageType.toString().substring(12).toUpperCase()} QR Code';
          inputsProvided = false;
        }
    }

    // URL-encode the inputString to handle special characters
    final String encodedInputString = Uri.encodeComponent(inputString);

    if (inputsProvided == true) {
      // Construct the QR Code API URL
      final String qrCodeUrl =
          'https://image-charts.com/chart?chl=$encodedInputString&choe=UTF-8&chs=200x200&cht=qr&chld=$errorString|0&icqrf=$forgroundColor&icqrb=$backgroundColor';
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

        if (error is FormatException) {
          errorMessage = 'Invalid QR code format. Please check your input.';
        } else if (error is SignalException) {
          errorMessage =
              'Network error. Please check your internet connection.';
        } else {
          errorMessage = 'An unexpected error occurred: $error';
        }
      }
    }
    // Show errorMessage in SnackBar
    if (errorMessage.isNotEmpty) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Input Fields for the QRcode Message
              MessageField(
                inputTextController: inputTextController,
                secondaryInputTextController: secondaryInputTextController,
                tertiaryInputTextController: tertiaryInputTextController,
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
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 400, maxHeight: 350),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      qrCodeImage.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.only(bottom: 30),
                              constraints: const BoxConstraints(
                                  maxWidth: 300, maxHeight: 250),
                              child: Material(
                                elevation: 5,
                                child: Image.network(
                                  qrCodeImage, // Display the QR code
                                ),
                              ),
                            )
                          : const SizedBox
                              .shrink(), // Show no space if no QR code

                      // Create QR Code Button
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Create/Recreate Button
                          FloatingActionButton.extended(
                            onPressed: _fetchQRCode,
                            label: Text(qrCodeImage.isNotEmpty
                                ? 'Recreate QR Code'
                                : 'Create QR Code'),
                          ),
                          // Save Button
                          if (qrCodeImage.isNotEmpty) ...[
                            const SizedBox(width: 10), // space between buttons
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
              Spacer(),
            ],
          ),
          Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    child: FloatingActionButton.small(
                      onPressed: () {
                        // got to settings page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        );
                      },
                      child: Icon(Icons.settings),
                      backgroundColor:
                          Theme.of(context).colorScheme.onInverseSurface,
                      heroTag: 'new',
                    ),
                  ),
                  const Spacer(),
                  // AI
                  Container(
                    padding: const EdgeInsets.all(18),
                    child: FloatingActionButton.small(
                      onPressed: () {
                        // got to settings page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AIPage()),
                        );
                      },
                      child: Icon(CupertinoIcons.sparkles),
                      heroTag: 'idk',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
