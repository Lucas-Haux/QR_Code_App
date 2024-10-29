import 'package:qr_code_generator/model/qr_code_data.dart';
import 'dart:convert';
import 'package:qr_code_generator/model/ai_image_data.dart';

String encodedBody() => jsonEncode({
      "functions": null,
      "variables": null,
      "qr_code_data": null,
      "qr_code_input_image": qrCodeImage,
      "qr_code_vcard": null,
      "qr_code_file": null,
      "use_url_shortener": true,
      "text_prompt": prompt.text,
      "negative_prompt": negativePrompt.text,
      "image_prompt": imagePrompt,
      "image_prompt_controlnet_models": [
        "sd_controlnet_canny",
        "sd_controlnet_depth",
        "sd_controlnet_tile"
      ],
      "image_prompt_strength": imageStrengthValue,
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
    });
