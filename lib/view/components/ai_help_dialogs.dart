import 'package:flutter/material.dart';

Future<void> brightnessDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Brightness:'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Default Value: 0.3',
            ),
            SizedBox(height: 12),
            Text(
              'Dictates how light the background of the QR Code will be. Contrast is desirable for readability.',
            ),
            SizedBox(height: 12),
            Text(
              'If the value is too low the Qr Code will be hard to read, if the value is too high the background of the Qr Code will be too bright and may look bad.',
            ),
            SizedBox(height: 12),
            Text(
              'Recomend Values are between 0.2 and 0.45',
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

Future<void> tilingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Data Clarity:'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Default Value: 0.3',
            ),
            SizedBox(height: 12),
            Text(
              'Dictates the blending of the Qr Code data and the Ai Art.',
            ),
            SizedBox(height: 12),
            Text(
              'The goal should be to keep this number as low as possible while keeping the qr code readable. If the value is too low the data wont stand out enough and wont read. If the value is too high it will ruin the image and look bad.',
            ),
            SizedBox(height: 12),
            Text(
              'Recomend Values are between 0.05 and 0.4',
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

Future<void> creativityDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AI Creativity:'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Default Value: 9',
            ),
            SizedBox(height: 12),
            Text(
              'Dictates how pressurized should the AI feel to produce what you want? How much creative freedom do you want the AI to have when interpreting your prompt?',
            ),
            SizedBox(height: 12),
            Text(
              'At lower values the image will effectively be random, at high values the image would be distorted.',
            ),
            SizedBox(height: 12),
            Text(
              'Recomend Values are between 5 and 9',
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
