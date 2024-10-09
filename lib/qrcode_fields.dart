import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

enum ErrorCorrectionLevel { L, M, Q, H }

ErrorCorrectionLevel selectedErrorCorrectionLevel = ErrorCorrectionLevel.L;

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

class InputSection extends StatefulWidget {
  final TextEditingController inputTextController;
  final Color currentMainColor;
  final Color currentBackgroundColor;
  final Color pickerMainColor;
  final Color pickerBackgroundColor;
  final ValueChanged<Color> onMainColorChanged;
  final ValueChanged<Color> onBackgroundColorChanged;

  const InputSection({
    Key? key,
    required this.inputTextController,
    required this.currentMainColor,
    required this.currentBackgroundColor,
    required this.pickerMainColor,
    required this.pickerBackgroundColor,
    required this.onMainColorChanged,
    required this.onBackgroundColorChanged,
  }) : super(key: key);

  @override
  _InputSectionState createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  // Default selected error correction level

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
            // TextField for input
            SizedBox(
              height: 56,
              width: 300,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
                controller: widget.inputTextController,
              ),
            ),
            const SizedBox(height: 16),
            // Error Correction
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error Correction Level'),
                IconButton(
                  onPressed: () {
                    showHelpDialog(context);
                  },
                  icon: const Icon(Icons.help),
                  iconSize: 17,
                ),
              ],
            ),
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
            // Main color Picker button
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
                          pickerColor: widget.pickerMainColor,
                          onColorChanged: widget.onMainColorChanged,
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
                  Icon(Icons.color_lens, color: widget.currentMainColor),
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
