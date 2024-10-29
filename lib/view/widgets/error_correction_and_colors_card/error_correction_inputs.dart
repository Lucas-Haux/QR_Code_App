import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/error_correction_dialog.dart';
import 'package:qr_code_generator/view/widgets/error_correction_and_colors_card/color_selectors.dart';
import 'package:qr_code_generator/model/inputs_data.dart';

class ErrorCorrectionsAndColorCard extends StatefulWidget {
  const ErrorCorrectionsAndColorCard({super.key});

  @override
  State<ErrorCorrectionsAndColorCard> createState() =>
      _ErrorCorrectionsAndColorCardState();
}

class _ErrorCorrectionsAndColorCardState
    extends State<ErrorCorrectionsAndColorCard> {
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
        constraints: const BoxConstraints(maxWidth: 350),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ErrorCorrection Text and Button
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error Correction Level:'),

                const SizedBox(width: 5), // space between Text and Icon

                // Help Button
                IconButton(
                  onPressed: () {
                    showHelpDialog(context);
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
            // SegmentedButton to select ErrorCorrection value
            const ErrorCorrectionButton(),

            const SizedBox(height: 5),

            const ColorSelectorsRow(),
          ],
        ),
      ),
    );
  }
}

class ErrorCorrectionButton extends StatefulWidget {
  const ErrorCorrectionButton({super.key});

  @override
  State<ErrorCorrectionButton> createState() => _ErrorCorrectionButtonState();
}

class _ErrorCorrectionButtonState extends State<ErrorCorrectionButton> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ErrorCorrectionLevel>(
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
        setState(() {
          selectedErrorCorrectionLevel = newSelection.first;
        });
      },
    );
  }
}
