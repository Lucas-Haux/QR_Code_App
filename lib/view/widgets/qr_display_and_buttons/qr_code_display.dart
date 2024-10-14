import 'package:flutter/material.dart';

class QRCodeDisplay extends StatelessWidget {
  final ValueNotifier<String>
      qrCodeImageNotifier; // ValueNotifier for QR code image

  const QRCodeDisplay({
    Key? key,
    required this.qrCodeImageNotifier, // Require the notifier to be passed in
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: qrCodeImageNotifier,
      builder: (context, qrCodeImage, child) {
        return qrCodeImage.isNotEmpty
            ? Container(
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 250),
                padding: const EdgeInsets.only(bottom: 30),
                child: Image.network(
                  qrCodeImage, // Display the QR code
                ),
              )
            : const SizedBox.shrink(); // Show no space if no QR code
      },
    );
  }
}
