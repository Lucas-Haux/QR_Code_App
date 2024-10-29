import 'package:flutter/material.dart';
import 'package:qr_code_generator/view/widgets/qr_display_and_buttons/qr_code_action_buttons.dart';

enum MessageType { text, link, wifi, email, contacts }

enum LinkType { http, https, raw }

enum WifiType { wep, wpa, eap, nopass }

enum ErrorCorrectionLevel { L, M, Q, H }

TextEditingController inputTextController = TextEditingController();
TextEditingController secondaryInputTextController = TextEditingController();
TextEditingController tertiaryInputTextController = TextEditingController();

MessageType selectedMessageType = MessageType.text;
ValueNotifier<MessageType> messageTypeNotifier =
    ValueNotifier<MessageType>(MessageType.text);
LinkType selectedLinkType = LinkType.https;
WifiType selectedWifiType = WifiType.wpa;
ErrorCorrectionLevel selectedErrorCorrectionLevel = ErrorCorrectionLevel.L;

Color pickerForegroundColor = const Color(0x000000);
Color pickerBackgroundColor = const Color(0xFFFFFF);
Color currentForegroundColor = pickerForegroundColor;
Color currentBackgroundColor = pickerBackgroundColor;

final inputDataLoss = MenuController();

// Set the inputString based on the selected message type
String inputString() {
  // Check Inputs for validation
  List<bool> providedInputs = [
    inputTextController.text.isNotEmpty,
    secondaryInputTextController.text.isNotEmpty,
    tertiaryInputTextController.text.isNotEmpty,
  ];
  errorMessage = '';
  try {
    return switch (selectedMessageType) {
      // return inputString formated for each messageType
      MessageType.text => providedInputs[0]
          ? inputTextController.text
          : throw Exception('Required input for TEXT not provided.'),
      MessageType.link => providedInputs[0]
          ? (selectedLinkType != LinkType.raw
              ? '${selectedLinkType.toString().substring(9)}://${inputTextController.text}'
              : inputTextController.text)
          : throw Exception('Required input for LINK not provided.'),
      MessageType.wifi => (providedInputs[0] && providedInputs[1])
          ? 'WIFI:T:${selectedWifiType.toString().substring(9).toUpperCase()};S:${inputTextController.text};P:${secondaryInputTextController.text};;'
          : errorMessage = 'Required provided Inputs for WIFI not provided.',
      MessageType.email => providedInputs[0]
          ? 'mailto:${inputTextController.text}' +
              (providedInputs[1]
                  ? '?subject=${secondaryInputTextController.text}'
                  : '')
          : throw Exception('Required inputs for EMAIL not provided.'),
      MessageType.contacts => (providedInputs[0] &&
              providedInputs[1] &&
              providedInputs[2])
          ? '''
BEGIN:VCARD
VERSION:3.0
N:${inputTextController.text}
TEL:${secondaryInputTextController.text}
ADR:${tertiaryInputTextController.text}
END:VCARD
'''
          : throw Exception(
              'Required provided Inputs for CONTACTS not provided. $providedInputs'),

      // Default case

      _ => throw Exception('Invalid message type.'),
    };
  } catch (e) {
    errorMessage = e.toString();

    throw Exception('inputString error');
  }
}
