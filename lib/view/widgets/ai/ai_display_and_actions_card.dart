import 'package:flutter/material.dart';
import 'package:qr_code_generator/model/ai_image_data.dart';
import 'package:qr_code_generator/model/image_save.dart';

class AiDisplayCard extends StatelessWidget {
  const AiDisplayCard({super.key});

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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isLoadingNotifier,
              builder: (context, isLoading, child) {
                return isLoading
                    ? Container(
                        constraints:
                            const BoxConstraints(maxWidth: 300, maxHeight: 301),
                        padding: const EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                          strokeCap: StrokeCap.round,
                        ),
                      )
                    : aiImage.isNotEmpty
                        ? Container(
                            constraints: const BoxConstraints(
                                maxWidth: 300, maxHeight: 301),
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                Image.network(
                                  aiImage, // Display the QR code

                                  scale: 2,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox
                            .shrink(); // Show no space if no QR code
              },
            ),
            const AiButton(),
          ],
        ),
      ),
    );
  }
}

class AiButton extends StatefulWidget {
  const AiButton({
    super.key,
  });

  @override
  State<AiButton> createState() => _AiButtonState();
}

class _AiButtonState extends State<AiButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          style: const ButtonStyle(elevation: WidgetStatePropertyAll(10)),
          onPressed: () {
            generateAiImage();
          },
          child: const Text("Create AI Image"),
        ),
        const SizedBox(width: 10),
        // Save Button
        ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, child) {
            return isLoading
                ? const SizedBox.shrink()
                : aiImage.isNotEmpty
                    ? IconButton.filledTonal(
                        onPressed: () => saveImage(context, aiImageResponse),
                        icon: const Icon(Icons.save),
                      )
                    : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
