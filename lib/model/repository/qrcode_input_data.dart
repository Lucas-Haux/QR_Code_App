import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/qrcode_message_enums.dart';

ErrorCorrectionLevel currentErrorCorrectionLevel = ErrorCorrectionLevel.H;

Color currentForegroundColor = const Color(0xff000000);
Color currentBackgroundColor = const Color(0xffffffff);

MessageType currentMessageType = MessageType.text;

LinkType currentLinkType = LinkType.https;

WifiType currentWifiType = WifiType.wpa;
