import 'package:flutter/material.dart';

import 'package:qr_code_generator/view/widgets/error_correction_and_colors_card/error_correction_button.dart';
import 'package:qr_code_generator/model/error_correction_dialog.dart';
import 'package:qr_code_generator/view/widgets/error_correction_and_colors_card/color_selectors.dart';

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

            const ColorSelectorsRow(),
          ],
        ),
      ),
    );
  }
}
