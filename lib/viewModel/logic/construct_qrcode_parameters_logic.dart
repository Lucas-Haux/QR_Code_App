import 'package:flutter/material.dart';
import 'package:qr_code_generator/model/qrcode_message_enums.dart';

String constructQrcodeInfo(
  Color foregroundColor,
  Color backgroundColor,
  ErrorCorrectionLevel errorCorrectionLevel,
  MessageType messageType,
  LinkType linkType,
  WifiType wifiType,
  TextEditingController firstController,
  TextEditingController secondController,
  TextEditingController thirdController,
) {
  String firstFormText = firstController.text;
  String secondFormText = secondController.text;
  String thirdFormText = thirdController.text;

  String message = _constructQrcodeMessage(
    foregroundColor,
    backgroundColor,
    errorCorrectionLevel,
    messageType,
    linkType,
    wifiType,
    firstFormText,
    secondFormText,
    thirdFormText,
  );
  return 'chl=$message&choe=UTF-8&chs=800x800&cht=qr&chld=${errorCorrectionLevel.name}|0&icqrf=${_colorToString(foregroundColor)}&icqrb=${_colorToString(backgroundColor)}';
}

// validates need text forms and provides Qrcode Message based on selected Message Type
String _constructQrcodeMessage(
  Color foregroundColor,
  Color backgroundColor,
  ErrorCorrectionLevel errorCorrectionLevel,
  MessageType messageType,
  LinkType linkType,
  WifiType wifiType,
  String firstFormText,
  String secondFormText,
  String thirdFormText,
) {
  // checks if needed text forms are filled
  // no longer in use except for checking the first form and rarely the 2nd
  void checkRequiredInputs(bool secondInput, bool thirdInput) {
    firstFormText.isEmpty ? throw 'error' : null;
    if (secondInput == true && secondFormText.isEmpty) {
      throw Exception('Second form text is empty.');
    }
    if (thirdInput == true && thirdFormText.isEmpty) {
      throw Exception('Second form text is empty.');
    }
  }

  switch (messageType) {
    case MessageType.text:
      checkRequiredInputs(false, false);
      return firstFormText;
    case MessageType.link:
      checkRequiredInputs(false, false);
      return _constructLinkMessage(firstFormText, linkType);
    case MessageType.wifi:
      checkRequiredInputs(wifiType != WifiType.nopass, false);
      return _constructWifismessage(firstFormText, secondFormText, wifiType);
    case MessageType.email:
      checkRequiredInputs(false, false);
      return _constructEmailMessage(firstFormText, secondFormText);
    case MessageType.contacts:
      checkRequiredInputs(false, false);
      return _constructContactsMessage(
        firstFormText,
        secondFormText,
        thirdFormText,
      );
  }
}

String _constructLinkMessage(String link, LinkType linkType) {
  if (linkType == LinkType.raw) {
    return link;
  } else {
    return '${linkType.name.toUpperCase()}://$link';
  }
}

String _constructWifismessage(String ssid, String password, WifiType wifiType) {
  if (wifiType != WifiType.nopass) {
    return 'WIFI:T:${wifiType.name.toUpperCase};S:$ssid;P:password;;';
  } else {
    return 'WIFI:T:${wifiType.name.toUpperCase};S:$ssid;;';
  }
}

String _constructEmailMessage(String address, String subject) {
  return 'mailto:$address?subject=$subject';
}

String _constructContactsMessage(String name, String phone, String address) {
  return '''
BEGIN:VCARD
VERSION:3.0
FN:$name
TEL;TYPE=CELL:$phone
ADR;TYPE=home:;;$address
END:VCARD
''';
}

String _colorToString(Color color) {
  return color.value
      .toRadixString(16)
      .padLeft(8, '0')
      .toUpperCase()
      .substring(2);
}
