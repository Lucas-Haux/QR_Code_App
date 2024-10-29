import 'package:flutter/material.dart';
import 'qr_code_display.dart';
import 'qr_code_action_buttons.dart';

class DisplayAndActionsCard extends StatelessWidget {
  // final QRCodeData qrCodeData =
  // QRCodeData(); // Create an instance of QRCodeData

  DisplayAndActionsCard({super.key});

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
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QRCodeDisplay(), // Displays the QR code

            // QR Code Buttons: create, recreate, save
            QRCodeActionButtons(),
          ],
        ),
      ),
    );
  }
}
