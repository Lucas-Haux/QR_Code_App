import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:qr_code_generator/model/qrcode_message_enums.dart';

class ErrorCorrectionAndColorsCard extends StatelessWidget {
  final void Function(Set<ErrorCorrectionLevel>) setErrorCorrection;
  final ValueNotifier<ErrorCorrectionLevel> errorCorrectionLevelNotifier;
  final ValueNotifier<Color> foregroundColorNotifier;
  final ValueNotifier<Color> backgroundColorNotifier;
  final void Function(bool, Color) colorUpdate;

  const ErrorCorrectionAndColorsCard({
    required this.setErrorCorrection,
    required this.errorCorrectionLevelNotifier,
    required this.foregroundColorNotifier,
    required this.backgroundColorNotifier,
    required this.colorUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Correction Text and Button
            _ErrorCorrectionComponent(
              setErrorCorrection: setErrorCorrection,
              errorCorrectionLevelNotifier: errorCorrectionLevelNotifier,
            ),
            const SizedBox(height: 10),
            // Row of color buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ColorPickerButton(
                  buttonLabel: 'Foreground',
                  colorNotifier: foregroundColorNotifier,
                  colorUpdate: colorUpdate,
                ),
                const Spacer(),
                _ColorPickerButton(
                  buttonLabel: 'Background',
                  colorNotifier: backgroundColorNotifier,
                  colorUpdate: colorUpdate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCorrectionComponent extends StatelessWidget {
  final void Function(Set<ErrorCorrectionLevel>) setErrorCorrection;
  final ValueNotifier<ErrorCorrectionLevel> errorCorrectionLevelNotifier;
  const _ErrorCorrectionComponent({
    required this.setErrorCorrection,
    required this.errorCorrectionLevelNotifier,
  });
  @override
  Widget build(BuildContext context) {
    const TextStyle segmentedButtonLabelStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.7, height: 0);

    return Column(
      children: [
        // ErrorCorrection Text and Help Button
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error Correction Level:'),

            const SizedBox(width: 5), // space between Text and Icon

            // Help Button
            IconButton(
              onPressed: () {
                _showHelpDialog(context);
              },
              icon: const Icon(Icons.help),
              iconSize: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.tertiaryFixedDim),
              ),
            ),
          ],
        ),
        // Error Correction Segmented Button
        ValueListenableBuilder<ErrorCorrectionLevel>(
          valueListenable: errorCorrectionLevelNotifier,
          builder: (context, selectedErrorCorrectionLevel, child) {
            return SegmentedButton<ErrorCorrectionLevel>(
              showSelectedIcon: false,
              emptySelectionAllowed: false,
              segments: const [
                ButtonSegment<ErrorCorrectionLevel>(
                  value: ErrorCorrectionLevel.L,
                  label: Text('Low', style: segmentedButtonLabelStyle),
                ),
                ButtonSegment(
                  value: ErrorCorrectionLevel.M,
                  label: Text('Medium', style: segmentedButtonLabelStyle),
                ),
                ButtonSegment(
                  value: ErrorCorrectionLevel.Q,
                  label: Text('Quartile', style: segmentedButtonLabelStyle),
                ),
                ButtonSegment(
                  value: ErrorCorrectionLevel.H,
                  label: Text('High', style: segmentedButtonLabelStyle),
                ),
              ],
              selected: {selectedErrorCorrectionLevel},
              onSelectionChanged: (Set<ErrorCorrectionLevel> newSelection) {
                setErrorCorrection(newSelection);
              },
            );
          },
        ),
      ],
    );
  }
}

void _showHelpDialog(BuildContext context) {
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

class _ColorPickerButton extends StatelessWidget {
  final String buttonLabel;
  final void Function(bool, Color) colorUpdate;
  final ValueNotifier<Color> colorNotifier;

  const _ColorPickerButton({
    required this.colorUpdate,
    required this.buttonLabel,
    required this.colorNotifier,
  });

  Color _getOutlineColor(Color mainColor) {
    // Use brightness to determine light or dark color
    final brightness = ThemeData.estimateBrightnessForColor(mainColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    Color pickerColor = colorNotifier.value;
    return Container(
      constraints: const BoxConstraints(maxWidth: 140, minWidth: 140),
      child: ValueListenableBuilder(
        valueListenable: colorNotifier,
        builder: (context, color, child) {
          return FilledButton.tonalIcon(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: pickerColor, // todo
                      onColorChanged: (pickerColor) {
                        if (buttonLabel == 'Foreground') {
                          colorUpdate(true, pickerColor);
                        } else {
                          colorUpdate(false, pickerColor);
                        }
                        Navigator.pop(context); // close dialog
                      },
                      enableLabel: false, // bug if true
                    ),
                  ),
                );
              },
            ),
            label: Text(buttonLabel, textScaler: const TextScaler.linear(0.89)),
            icon: Stack(
              children: [
                Icon(
                  Icons.color_lens,
                  color: color,
                ),
                Icon(
                  Icons.color_lens_outlined,
                  color: _getOutlineColor(color),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          );
        },
      ),
    );
  }
}
