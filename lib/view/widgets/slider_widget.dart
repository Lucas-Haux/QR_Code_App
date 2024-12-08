import 'package:flutter/material.dart';

class AiSlider extends StatelessWidget {
  final ValueChanged<double> onChanged;
  final double max;
  final ValueNotifier<double> valueNotifier;

  const AiSlider({
    required this.onChanged,
    required this.max,
    required this.valueNotifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: valueNotifier,
      builder: (context, value, _) {
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: max,
            label: max <= 1 ? value.toString() : value.round().toString(),
            divisions: 20,
            onChanged: (value) {
              onChanged(value);
            },
          ),
        );
      },
    );
  }
}
