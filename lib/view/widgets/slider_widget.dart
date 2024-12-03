import 'package:flutter/material.dart';

class AiSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  const AiSlider({
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        label: max <= 1 ? value.toString() : value.round().toString(),
        divisions: 20,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
