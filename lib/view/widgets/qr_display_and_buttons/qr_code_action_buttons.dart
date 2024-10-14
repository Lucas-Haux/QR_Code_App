import 'package:flutter/material.dart';
import 'package:qr_code_app/model/qr_code_data.dart'; // Your QR code logic file
import 'package:qr_code_app/model/image_save.dart';

class QRCodeActionButtons extends StatefulWidget {
  final ValueNotifier<String> qrCodeImageNotifier;

  const QRCodeActionButtons({
    required this.qrCodeImageNotifier,
    Key? key,
  }) : super(key: key);

  @override
  _QRCodeActionButtonsState createState() => _QRCodeActionButtonsState();
}

class _QRCodeActionButtonsState extends State<QRCodeActionButtons> {
  final QRCodeData qrCodeData = QRCodeData();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Create/Recreate Button
        FloatingActionButton.extended(
          onPressed: () {
            qrCodeData.fetchQRCode(context); // Fetch QR code data
            widget.qrCodeImageNotifier.value =
                qrCodeData.constructQRCodeUrl(); // Update the notifier
            print(qrCodeData.constructQRCodeUrl());
          },
          label: Text(
              qrCodeImage.isNotEmpty ? 'Recreate QR Code' : 'Create QR Code'),
        ),
        const SizedBox(width: 10),
        // Save Button
        ValueListenableBuilder<String>(
          valueListenable: widget.qrCodeImageNotifier,
          builder: (context, qrCodeImage, child) {
            return qrCodeImage.isNotEmpty
                ? FloatingActionButton(
                    onPressed: () => saveImage(context, response),
                    child: const Icon(Icons.save),
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
