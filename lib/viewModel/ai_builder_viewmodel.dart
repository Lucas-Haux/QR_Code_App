import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:qr_code_generator/viewModel/logic/save_image_logic.dart';
import 'package:qr_code_generator/model/repository/ai_data_repository.dart';
import 'package:qr_code_generator/model/repository/ai_input_data.dart';
import 'package:qr_code_generator/model/repository/qrcode_data_repository.dart';

ValueNotifier<String> aiImageUrlNotifier = ValueNotifier<String>('');

TextEditingController textPromptController = TextEditingController();
TextEditingController negativeTextPromptController = TextEditingController();

ValueNotifier<File?> referenceImageNotifier = ValueNotifier<File?>(null);
double currentReferenceImageStrengthValue = referenceImageStrengthValue;
double currentBrightnessValue = brightnessValue;
double currentTilingValue = tilingValue;
double currentQrScaleValue = qrScaleValue;
double currentGuidanceValue = guidanceValue;

class AiBuilderViewmodel {
  final subscription = aiUrlController.stream.listen((data) {
    aiImageUrlNotifier.value = data;
    print('found something: $data');
  });

  Future<void> saveImage() async {
    await saveQrcodeImage(aiImageFile);
  }

  Future<void> updateAiUrl() async {
    try {
      String aiParameters = _constructAiParameters();
      print('got aiParameters');

      await AiDataRepository().updateAi(aiParameters);
    } catch (e) {
      print('failed to update ai url: $e');
      throw 'failed to update ai url: $e';
    }
  }

  void setReferenceImageStrengthValue(double value) {
    referenceImageStrengthValue = value;
    currentReferenceImageStrengthValue == value;
  }

  void setBrightnessValue(double value) {
    brightnessValue = value;
    currentBrightnessValue = value;
  }

  void setTilingValue(double value) {
    tilingValue = value;
    currentTilingValue = value;
  }

  void setQrScaleValue(double value) {
    qrScaleValue = value;
    currentQrScaleValue = value;
  }

  void setGuidanceValue(double value) {
    guidanceValue = value;
    currentGuidanceValue = value;
  }
}

String _constructAiParameters() {
  try {
    return jsonEncode(
      {
        "functions": null,
        "variables": null,
        "qr_code_data": null,
        "qr_code_input_image": qrcodeUrl,
        "qr_code_vcard": null,
        "qr_code_file": null,
        "use_url_shortener": true,
        "text_prompt": "test",
        "negative_prompt": "",
        "image_prompt": imagePrompt,
        "image_prompt_controlnet_models": [
          "sd_controlnet_canny",
          "sd_controlnet_depth",
          "sd_controlnet_tile"
        ],
        "image_prompt_strength": referenceImageStrengthValue,
        "image_prompt_scale": 1,
        "image_prompt_pos_x": 0.5,
        "image_prompt_pos_y": 0.5,
        "selected_model": "dream_shaper", // this
        "selected_controlnet_model": [
          "sd_controlnet_brightness",
          "sd_controlnet_tile"
        ],
        "output_width": 512,
        "output_height": 512,
        "guidance_scale": guidanceValue,
        "controlnet_conditioning_scale": [brightnessValue, tilingValue],
        "num_outputs": 1,
        "quality": 80,
        "scheduler": "euler_ancestral",
        "seed": 1628099939, // this
        "obj_scale": qrScaleValue,
        "obj_pos_x": 0.5,
        "obj_pos_y": 0.5
      },
    );
  } catch (e) {
    print('failed to _constructAiParameters $e');
    throw ' failed to _constructAiParameters $e';
  }
}
