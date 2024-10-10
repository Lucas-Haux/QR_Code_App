import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:qr_code_app/qr_message.dart';

enum MessageType { text, link, wifi }

enum LinkType { http, https, raw }

enum ErrorCorrectionLevel { L, M, Q, H }

// Default Selected items
LinkType selectedLinkType = LinkType.https;
MessageType selectedMessageType = MessageType.text;
ErrorCorrectionLevel selectedErrorCorrectionLevel = ErrorCorrectionLevel.L;

// Fuction to show ErrorCorrectionLevel Help dialog
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

// Widgit for all the QRcode Input Fields
class InputSection extends StatefulWidget {
  final TextEditingController inputTextController;
  final Color currentForgroundColor;
  final Color currentBackgroundColor;
  final Color pickerForgroundColor;
  final Color pickerBackgroundColor;
  final ValueChanged<Color> onForgroundColorChanged;
  final ValueChanged<Color> onBackgroundColorChanged;
  final bool isLinkMessageActive;
  final ValueChanged<bool> onLinkMessageActiveChanged;

  const InputSection({
    Key? key,
    required this.inputTextController,
    required this.currentForgroundColor,
    required this.currentBackgroundColor,
    required this.pickerForgroundColor,
    required this.pickerBackgroundColor,
    required this.onForgroundColorChanged,
    required this.onBackgroundColorChanged,
    required this.isLinkMessageActive,
    required this.onLinkMessageActiveChanged,
  }) : super(key: key);

  @override
  InputSectionState createState() => InputSectionState();
}

class InputSectionState extends State<InputSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Fields for the QRcode Message
            MessageField(
              inputTextController: widget.inputTextController,
              isLinkMessageActive: widget.isLinkMessageActive,
              onLinkMessageActiveChanged: widget.onLinkMessageActiveChanged,
            ),
            const SizedBox(height: 16),
            // Error Correction Text and Iconbutton
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error Correction Level'),
                IconButton(
                  onPressed: () {
                    showHelpDialog(context); // help dialog
                  },
                  icon: const Icon(Icons.help),
                  iconSize: 17,
                ),
              ],
            ),
            // ErrorCorrectionslevel selection button
            SegmentedButton<ErrorCorrectionLevel>(
              showSelectedIcon: false,
              emptySelectionAllowed: false,
              segments: const [
                ButtonSegment<ErrorCorrectionLevel>(
                  value: ErrorCorrectionLevel.L,
                  label: Text('Low'),
                ),
                ButtonSegment(
                  value: ErrorCorrectionLevel.M,
                  label: Text('Medium'),
                ),
                ButtonSegment(
                  value: ErrorCorrectionLevel.Q,
                  label: Text('Quartile'),
                ),
                ButtonSegment(
                  value: ErrorCorrectionLevel.H,
                  label: Text('High'),
                ),
              ],
              selected: <ErrorCorrectionLevel>{selectedErrorCorrectionLevel},
              onSelectionChanged: (Set<ErrorCorrectionLevel> newSelection) {
                setState(
                  () {
                    selectedErrorCorrectionLevel = newSelection.first;
                  },
                );
              },
              style: SegmentedButton.styleFrom(
                elevation: 5,
              ),
            ),
            const SizedBox(height: 16),
            // Foreground color Picker button
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: widget.pickerForgroundColor,
                          onColorChanged: widget.onForgroundColorChanged,
                          enableLabel: true,
                        ),
                      ),
                    );
                  },
                );
              },
              label: const Text('Foreground Color'),
              icon: Stack(
                children: [
                  Icon(Icons.color_lens, color: widget.currentForgroundColor),
                  const Icon(Icons.color_lens_outlined, color: Colors.black),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            // Background color Picker button
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: widget.pickerBackgroundColor,
                          onColorChanged: widget.onBackgroundColorChanged,
                          enableLabel: true,
                        ),
                      ),
                    );
                  },
                );
              },
              label: const Text('Background Color'),
              icon: Stack(
                children: [
                  Icon(Icons.color_lens, color: widget.currentBackgroundColor),
                  const Icon(Icons.color_lens_outlined, color: Colors.black),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
