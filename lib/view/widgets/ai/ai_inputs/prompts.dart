import 'package:flutter/rendering.dart';
import 'dart:io';

import 'package:path/path.dart';

import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/ai_image_data.dart';

import 'package:qr_code_generator/model/image_pick_crop_upload.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'ai_settings.dart';

class AiPrompts extends StatefulWidget {
  const AiPrompts({super.key});

  @override
  State<AiPrompts> createState() => AiPromptsState();
}

class AiPromptsState extends State<AiPrompts> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340, minWidth: 340),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text Prompt
            SizedBox(
              width: 300,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Text Prompt',
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Text Promt',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  controller: prompt,
                  validator: (value) {
                    return value.toString().isEmpty
                        ? 'Text Prompt Can Not Be Empty'
                        : null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Negative Prompt
            SizedBox(
              width: 300,
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLines: 2,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Negative Prompt',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a negative prompt',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
                controller: negativePrompt,
              ),
            ),
            const SizedBox(height: 20),
            // TODO sizedbox for button and forms should be around column
            ValueListenableBuilder<File?>(
              valueListenable: referenceImageNotifier,
              builder: (context, image, child) {
                return Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: OutlinedButton.icon(
                              onPressed: () {
                                pickImage();
                              },
                              icon: const Icon(Icons.image_search),
                              label: AutoSizeText(
                                image == null
                                    ? 'Refence Image'
                                    : basename(image.path),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ), // todo fix when image change
                            ),
                          ),
                          if (image != null)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  image = null;
                                  imagePrompt = "";
                                });
                                referenceImageNotifier.value = null;
                              },
                              icon: const Icon(Icons.close),
                            ),
                        ],
                      ),
                    ),
                    if (image != null)
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          const Text('Image Prompt Strength'),
                          // defined in ai_settings.dart
                          AISlider(
                            value: imageStrengthValue,
                            onChanged: (value) {
                              setState(() {
                                imageStrengthValue = value;
                              });
                            },
                            min: 0,
                            max: 1,
                          )
                        ],
                      )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
