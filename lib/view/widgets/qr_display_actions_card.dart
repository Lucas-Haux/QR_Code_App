import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/qr_code_data.dart';
import 'package:qr_code_generator/model/image_save.dart';

class DisplayAndActionsCard extends StatelessWidget {
  // final QRCodeData qrCodeData =
  // QRCodeData(); // Create an instance of QRCodeData

  const DisplayAndActionsCard({super.key});

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
        constraints:
            const BoxConstraints(maxWidth: 340, maxHeight: 350, minWidth: 340),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<String>(
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
            ),

            // QR Code Buttons: create, recreate, save
            const QRCodeActionButtons(),
          ],
        ),
      ),
    );
  }
}

String errorMessage = '';

class QRCodeActionButtons extends StatefulWidget {
  const QRCodeActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  QRCodeActionButtonsState createState() => QRCodeActionButtonsState();
}

class QRCodeActionButtonsState extends State<QRCodeActionButtons> {
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
                fetchQRCode(context); // Fetch QR code data
                errorMessage.isNotEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      )
                    : const SizedBox.shrink();
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
