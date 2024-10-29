import 'package:flutter/material.dart';

void showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error Correction Level:'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QR codes can recover from different levels of damage, depending on the error correction level you choose. '
              'Here’s how each level works:',
            ),
            SizedBox(height: 12),
            Text(
              'Low (7% recovery):\nBest for simple codes with minimal damage or obstruction. It allows the QR code to hold more data but provides limited error correction.',
            ),
            SizedBox(height: 12),
            Text(
              'Medium (15% recovery):\nA balanced choice between data storage and error correction. Suitable for environments with a small risk of the code being partially damaged.',
            ),
            SizedBox(height: 12),
            Text(
              'Quartile (25% recovery):\nOffers a higher level of error correction. This option is useful if you expect the QR code to potentially be damaged or obscured.',
            ),
            SizedBox(height: 12),
            Text(
              'High (30% recovery):\nProvides the strongest error correction, making it ideal for codes that may suffer significant damage or be used in harsh conditions. However, it reduces the amount of storable data.',
            ),
          ],
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
