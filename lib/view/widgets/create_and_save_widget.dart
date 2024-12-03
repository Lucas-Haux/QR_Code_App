import 'package:flutter/material.dart';

class CreateAndSaveButtons extends StatelessWidget {
  final ValueNotifier<String> qrcodeImageUrlNotifier;
  final VoidCallback saveImageFunction;
  final VoidCallback updateQrcodeFunction;
  const CreateAndSaveButtons({
    required this.qrcodeImageUrlNotifier,
    required this.saveImageFunction,
    required this.updateQrcodeFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Create/Recreate Button
        ValueListenableBuilder<String>(
          valueListenable: qrcodeImageUrlNotifier,
          builder: (context, qrCodeImage, child) {
            return FilledButton(
              onPressed: updateQrcodeFunction,
              child: Text(qrCodeImage.isNotEmpty
                  ? 'Recreate QR Code'
                  : 'Create QR Code'),
            );
          },
        ),

        const SizedBox(width: 10), // space between both buttons

        // Save Button
        ValueListenableBuilder<String>(
          valueListenable: qrcodeImageUrlNotifier,
          builder: (context, qrCodeImage, child) {
            return qrCodeImage.isNotEmpty
                ? IconButton.filledTonal(
                    onPressed: saveImageFunction,
                    icon: const Icon(Icons.save),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
