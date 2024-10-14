import 'package:flutter/material.dart';

enum MessageType { text, link, wifi, email, contacts }

enum LinkType { http, https, raw }

enum WifiType { wep, wpa, eap, nopass }

LinkType selectedLinkType = LinkType.https;
MessageType selectedMessageType = MessageType.text;
ErrorCorrectionLevel selectedErrorCorrectionLevel = ErrorCorrectionLevel.L;

WifiType selectedWifiType = WifiType.wpa;

enum ErrorCorrectionLevel { L, M, Q, H }

TextEditingController inputTextController = TextEditingController();
TextEditingController secondaryInputTextController = TextEditingController();
TextEditingController tertiaryInputTextController = TextEditingController();
final inputDataLoss = MenuController();

Color pickerForegroundColor = const Color(0x9E9E9E);
Color pickerBackgroundColor = const Color(0xFFFFFF);

Color currentForegroundColor = pickerForegroundColor;
Color currentBackgroundColor = pickerBackgroundColor;

// Set the inputString based on the selected message type
String inputString() {
// Check inputs for validation
  List<bool> inputs = [
    inputTextController.text.isNotEmpty,
    secondaryInputTextController.text.isNotEmpty,
    tertiaryInputTextController.text.isNotEmpty,
  ];

  print(Text('inputstring function $inputTextController.'));
  print(secondaryInputTextController.text);
  return switch (selectedMessageType) {
    MessageType.text => inputs[0]
        ? inputTextController.text
        : throw Exception('Required input for TEXT not provided.'),
    MessageType.link => inputs[0]
        ? (selectedLinkType != LinkType.raw
            ? '${selectedLinkType.toString().substring(9)}://${inputTextController.text}'
            : inputTextController.text)
        : throw Exception('Required input for LINK not provided.'),
    MessageType.wifi => (inputs[0] && inputs[1])
        ? 'WIFI:T:${selectedWifiType.toString().substring(9).toUpperCase()};S:${inputTextController.text};P:${secondaryInputTextController.text};;'
        : throw Exception('Required inputs for WIFI not provided.'),
    MessageType.email => inputs[0]
        ? 'mailto:${inputTextController.text}' +
            (inputs[1] ? '?subject=${secondaryInputTextController.text}' : '')
        : throw Exception('Required input for EMAIL not provided.'),
    MessageType.contacts => (inputs[0] && inputs[1] && inputs[2])
        ? '''
BEGIN:VCARD
VERSION:3.0
N:${inputTextController.text}
TEL:${secondaryInputTextController.text}
ADR:${tertiaryInputTextController.text}
END:VCARD
'''
        : throw Exception('Required inputs for CONTACTS not provided. $inputs'),

    // Default case
    _ => throw Exception('Invalid message type.'),
  };
}
