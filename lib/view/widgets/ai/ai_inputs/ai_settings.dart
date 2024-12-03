import 'package:flutter/material.dart';

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
