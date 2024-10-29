import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/ai_image_data.dart';
import 'package:qr_code_generator/view/components/ai_help_dialogs.dart';

class AiSettings extends StatefulWidget {
  const AiSettings({super.key});

  @override
  AiSettingsState createState() => AiSettingsState();
}

class AiSettingsState extends State<AiSettings> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340, minWidth: 340),
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LabelRow(label: 'Brightness', dialog: brightnessDialog),
            AISlider(
              value: brightnessValue,
              onChanged: (value) {
                setState(() {
                  brightnessValue = value;
                });
              },
              min: 0,
              max: 1,
            ),
            const SizedBox(height: 10),
            const LabelRow(label: 'Data Clarity', dialog: tilingDialog),
            AISlider(
              value: tilingValue,
              onChanged: (value) {
                setState(() {
                  tilingValue = value;
                });
              },
              min: 0,
              max: 1,
            ),
            const SizedBox(height: 10),
            const LabelRow(label: 'AI Creativity', dialog: creativityDialog),
            AISlider(
              min: 0,
              max: 20,
              value: guidanceValue,
              onChanged: (value) {
                setState(() {
                  guidanceValue = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text('QR Code Scale'),
            AISlider(
              min: 0,
              max: 1,
              value: qrScaleValue,
              onChanged: (value) {
                setState(() {
                  qrScaleValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AISlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  const AISlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  @override
  State<AISlider> createState() => _AISliderState();
}

class _AISliderState extends State<AISlider> {
  late double sliderValue;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTickMarkColor: Colors.transparent, // Hide active division dots
        inactiveTickMarkColor:
            Colors.transparent, // Hide inactive division dots
      ),
      child: Slider(
        value: sliderValue,
        min: widget.min,
        max: widget.max,
        label: widget.max <= 1
            ? sliderValue.toString()
            : sliderValue.round().toString(),
        divisions: 20, // Keep divisions
        onChanged: (value) {
          setState(() {
            sliderValue = value;
          });
          widget.onChanged(value); // Notify parent widget
        },
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  final String label;
  final Future<void> Function(BuildContext) dialog;

  const LabelRow({
    super.key,
    required this.label,
    required this.dialog,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 5), // space between Text and Icon

        // Help Button
        IconButton(
          onPressed: () async {
            await dialog(context);
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
    );
  }
}
