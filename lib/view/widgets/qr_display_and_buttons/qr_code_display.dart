import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/qr_code_data.dart';

class QRCodeDisplay extends StatelessWidget {
  const QRCodeDisplay({
    Key? key,
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
