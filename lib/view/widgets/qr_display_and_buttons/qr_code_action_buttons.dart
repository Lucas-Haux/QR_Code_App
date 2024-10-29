import 'package:flutter/material.dart';
import 'package:qr_code_generator/model/qr_code_data.dart'; // Your QR code logic file
import 'package:qr_code_generator/model/image_save.dart';

String errorMessage = '';

class QRCodeActionButtons extends StatefulWidget {
  const QRCodeActionButtons({
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
        ValueListenableBuilder<String>(
          valueListenable: qrCodeImageNotifier,
          builder: (context, qrCodeImage, child) {
            return FilledButton(
              onPressed: () {
                qrCodeData.fetchQRCode(context); // Fetch QR code data
                errorMessage.isNotEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      )
                    : SizedBox.shrink();

                // Update the notifier
                print(qrCodeImage);
              },
              child: Text(qrCodeImage.isNotEmpty
                  ? 'Recreate QR Code'
                  : 'Create QR Code'),
            );
          },
        ),
        const SizedBox(width: 10),
        // Save Button
        ValueListenableBuilder<String>(
          valueListenable: qrCodeImageNotifier,
          builder: (context, qrCodeImage, child) {
            return qrCodeImage.isNotEmpty
                ? IconButton.filledTonal(
                    onPressed: () => saveImage(context, response),
                    icon: const Icon(Icons.save),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
