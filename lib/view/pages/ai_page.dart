import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
                const _AiSettingsCard(),

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
              ImageDisplay(
                qrcodeImageUrlNotifier: qrcodeImageUrlNotifier,
                loadingNotifier: aiLoadingNotifier,
              ),
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
  final ValueNotifier<String> referenceImageNotifier;
  final ValueNotifier<double> referenceImageStrengthValue;
  final ValueChanged<double> setReferenceImage;

  const _AiPromptCard({
    required this.referenceImageStrengthValue,
    required this.textPromptController,
    required this.negativeTextPromptController,
    required this.referenceImageNotifier,
    required this.setReferenceImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: 340, minWidth: 340, maxHeight: 350),
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
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
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
                                AiBuilderViewmodel().pickImage();
                              },
                              icon: const Icon(Icons.image_search),
                              label: AutoSizeText(
                                image.isEmpty
                                    ? 'Refence Image'
                                    : basename(image),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ), // todo fix when image change
                            ),
                          ),
                          if (image.isNotEmpty)
                            IconButton(
                              onPressed: () {
                                // remove reference image
                                referenceImageNotifier.value = "";
                              },
                              icon: const Icon(Icons.close),
                            ),
                        ],
                      ),
                    ),
                    if (image.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          const Text('Image Prompt Strength'),
                          // defined in ai_settings.dart
                          AiSlider(
                            onChanged: setReferenceImage,
                            max: 1,
                            valueNotifier: referenceImageStrengthValue,
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

class _AiSettingsCard extends StatelessWidget {
  const _AiSettingsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340, minWidth: 340),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _LabelRow(label: 'Data Clarity', dialog: tilingDialog),
            AiSlider(
              valueNotifier: currentTilingValue,
              onChanged: AiBuilderViewmodel().setTilingValue,
              max: 1,
            ),
            const SizedBox(height: 10),
            const _LabelRow(label: 'Brightness', dialog: brightnessDialog),
            AiSlider(
              valueNotifier: currentBrightnessValue,
              onChanged: AiBuilderViewmodel().setBrightnessValue,
              max: 1,
            ),
            const SizedBox(height: 10),
            const _LabelRow(label: 'AI Creativity', dialog: creativityDialog),
            AiSlider(
              valueNotifier: currentGuidanceValue,
              onChanged: AiBuilderViewmodel().setGuidanceValue,
              max: 20,
            ),
            const SizedBox(height: 10),
            const Text('QR Code Scale'),
            AiSlider(
              valueNotifier: currentQrScaleValue,
              onChanged: AiBuilderViewmodel().setQrScaleValue,
              max: 1,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
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
