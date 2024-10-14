import 'package:flutter/material.dart';

import 'package:qr_code_app/model/inputs_data.dart';

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
        setState(
          () {
            selectedErrorCorrectionLevel = newSelection.first;
          },
        );
      },
      style: SegmentedButton.styleFrom(
        elevation: 5,
      ),
    );
  }
}
