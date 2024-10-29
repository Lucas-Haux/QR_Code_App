import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/ai_image_data.dart';
import 'package:qr_code_generator/model/image_save.dart';
import 'package:http/http.dart' as http;

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
        ValueListenableBuilder<String>(
          valueListenable: aiNotifier,
          builder: (context, aiImage, child) {
            return aiImage.isNotEmpty
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
