import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qr_code_generator/view/widgets/ai/ai_inputs/ai_settings.dart';

import 'package:qr_code_generator/view/widgets/image_display_widget.dart';
import 'package:qr_code_generator/view/widgets/create_and_save_widget.dart';
import 'package:qr_code_generator/view/widgets/input_form_widget.dart';
import 'package:qr_code_generator/view/widgets/slider_widget.dart';

import 'package:qr_code_generator/viewModel/ai_builder_viewmodel.dart';

import 'package:qr_code_generator/view/components/ai_help_dialog.dart';

class AIPage extends StatelessWidget {
  const AIPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('AI QR Code Generator'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus when tapping outside
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _AiPromptCard(
                  textPromptController: textPromptController,
                  negativeTextPromptController: negativeTextPromptController,
                  referenceImageNotifier: referenceImageNotifier,
                  referenceImageStrengthValue:
                      currentReferenceImageStrengthValue,
                  setReferenceImage:
                      AiBuilderViewmodel().setReferenceImageStrengthValue,
                ),

                // display and create/save buttons
                _AiQrcodeImageDisplayAndButtonsCard(
                  saveImageFunction: AiBuilderViewmodel().saveImage,
                  updateQrcodeFunction: AiBuilderViewmodel().updateAiUrl,
                  qrcodeImageUrlNotifier: aiImageUrlNotifier,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AiQrcodeImageDisplayAndButtonsCard extends StatelessWidget {
  final ValueNotifier<String> qrcodeImageUrlNotifier;
  final VoidCallback saveImageFunction;
  final VoidCallback updateQrcodeFunction;
  const _AiQrcodeImageDisplayAndButtonsCard({
    required this.saveImageFunction,
    required this.updateQrcodeFunction,
    required this.qrcodeImageUrlNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: 340, minWidth: 340, maxHeight: 350),
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageDisplay(qrcodeImageUrlNotifier: qrcodeImageUrlNotifier),
              CreateAndSaveButtons(
                qrcodeImageUrlNotifier: qrcodeImageUrlNotifier,
                saveImageFunction: saveImageFunction,
                updateQrcodeFunction: updateQrcodeFunction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiPromptCard extends StatelessWidget {
  final TextEditingController textPromptController;
  final TextEditingController negativeTextPromptController;
  final ValueNotifier<File?> referenceImageNotifier;
  final double referenceImageStrengthValue;
  final ValueChanged<double> setReferenceImage;

  const _AiPromptCard({
    required this.textPromptController,
    required this.negativeTextPromptController,
    required this.referenceImageNotifier,
    required this.referenceImageStrengthValue,
    required this.setReferenceImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340, minWidth: 340),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputForm(
              labelText: 'Prompt',
              hintText: 'Enter Prompt',
              textController: textPromptController,
            ),
            const SizedBox(height: 10),
            InputForm(
              labelText: 'Negative Prompt',
              hintText: 'Enter Negtive Prompt',
              textController: negativeTextPromptController,
              opitional: true,
            ),
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
                                // pick image
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
                                // remove reference image
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
                            value: referenceImageStrengthValue,
                            onChanged: setReferenceImage,
                            min: 0,
                            max: 1,
                          ),
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

class _AiSettingsCard extends StatelessWidget {
  const _AiSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        _LabelRow(label: 'Data Clarity', dialog: tilingDialog),
      ],
    ));
  }
}

class _LabelRow extends StatelessWidget {
  final String label;
  final Future<void> Function(BuildContext) dialog;

  const _LabelRow({
    required this.label,
    required this.dialog,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 5), // space between Text and Icon

        // Help Button
        IconButton(
          onPressed: () async {
            await dialog(context);
          },
          icon: const Icon(Icons.help),
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.tertiaryFixedDim),
          ),
        ),
      ],
    );
  }
}
