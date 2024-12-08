import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/repository/qrcode_data_repository.dart';
import 'package:qr_code_generator/model/repository/qrcode_input_data.dart';
import 'package:qr_code_generator/model/qrcode_message_enums.dart';
import 'package:qr_code_generator/viewModel/logic/construct_qrcode_parameters_logic.dart';
import 'package:qr_code_generator/viewModel/logic/save_image_logic.dart';

ValueNotifier<String> qrcodeImageUrlNotifier = ValueNotifier<String>('');
ValueNotifier<bool> qrcodeLoadingNotifier = ValueNotifier<bool>(false);

ValueNotifier<ErrorCorrectionLevel> errorCorrectionLevelNotifier =
    ValueNotifier<ErrorCorrectionLevel>(currentErrorCorrectionLevel);

ValueNotifier<Color> foregroundColorNotifier =
    ValueNotifier<Color>(currentForegroundColor);

ValueNotifier<Color> backgroundColorNotifier =
    ValueNotifier<Color>(currentBackgroundColor);

ValueNotifier<MessageType> messageTypeNotifier =
    ValueNotifier<MessageType>(currentMessageType);

ValueNotifier<LinkType> linkTypeNotifier =
    ValueNotifier<LinkType>(currentLinkType);

ValueNotifier<WifiType> wifiTypeNotifier =
    ValueNotifier<WifiType>(currentWifiType);

TextEditingController firstTextController = TextEditingController();
TextEditingController secondTextController = TextEditingController();
TextEditingController thirdTextController = TextEditingController();

class QrHomepageViewmodel extends ChangeNotifier {
  final subscription = qrcodeUrlController.stream.listen((data) {
    qrcodeImageUrlNotifier.value = data;
  });

  void updateUrl() {
    String qrcodeInfo = constructQrcodeInfo(
      currentForegroundColor,
      currentBackgroundColor,
      currentErrorCorrectionLevel,
      currentMessageType,
      currentLinkType,
      currentWifiType,
      firstTextController,
      secondTextController,
      thirdTextController,
    );
    qrcodeImageUrlNotifier.value = "";
    qrcodeLoadingNotifier.value = true;
    QrcodeDataRepository().updateQrcode(qrcodeInfo);
    qrcodeLoadingNotifier.value = false;
  }

  Future<void> saveImage() async {
    await saveQrcodeImage(qrcodeImageFile);
  }

  void setErrorCorrection(
      Set<ErrorCorrectionLevel> selectedErrorCorrectionLevel) {
    currentErrorCorrectionLevel = selectedErrorCorrectionLevel.toList()[0];

    errorCorrectionLevelNotifier.value =
        selectedErrorCorrectionLevel.toList()[0]; // pretty sure this is wrong
  }

  void setColor(bool foreground, Color newColor) {
    if (foreground == true) {
      currentForegroundColor = newColor;
      foregroundColorNotifier.value = newColor;
    } else {
      currentBackgroundColor = newColor;
      backgroundColorNotifier.value = newColor;
    }
  }

  void setMessageType(MessageType newMessageType) {
    currentMessageType = newMessageType;
    messageTypeNotifier.value = newMessageType;
  }

  void setLinkType(LinkType newLinkType) {
    currentLinkType = newLinkType;
    linkTypeNotifier.value = newLinkType;
  }

  void setWifiType(WifiType newWifiType) {
    currentWifiType = newWifiType;
    wifiTypeNotifier.value = newWifiType;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
