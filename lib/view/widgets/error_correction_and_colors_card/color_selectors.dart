import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:qr_code_app/model/inputs_data.dart';

class ColorSelectorsRow extends StatefulWidget {
  const ColorSelectorsRow({super.key});

  @override
  State<ColorSelectorsRow> createState() => _ColorSelectorsRowState();
}

class _ColorSelectorsRowState extends State<ColorSelectorsRow> {
  void onForegroundColorChanged(Color color) {
    setState(() {
      currentForegroundColor = color;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pop(context);
    });
  }

  void onBackgroundColorChanged(Color color) {
    setState(() {
      currentBackgroundColor = color;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Foreground color Picker button
        Container(
          constraints: const BoxConstraints(maxWidth: 140, minWidth: 140),
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(0),
                    content: SingleChildScrollView(
                      child: MaterialPicker(
                        pickerColor: pickerForegroundColor,
                        onColorChanged: onForegroundColorChanged,
                        enableLabel: true,
                      ),
                    ),
                  );
                },
              );
            },
            label:
                const Text('Foreground', textScaler: TextScaler.linear(0.89)),
            icon: Stack(
              children: [
                Icon(Icons.color_lens, color: currentForegroundColor),
                // stroke outline around Icon
                const Icon(Icons.color_lens_outlined, color: Colors.black),
              ],
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),

        const SizedBox(width: 15), // space between both buttons

        // Background color Picker button
        Container(
          constraints: const BoxConstraints(maxWidth: 140, minWidth: 140),
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(0),
                    content: SingleChildScrollView(
                      child: MaterialPicker(
                        pickerColor: pickerForegroundColor,
                        onColorChanged: onBackgroundColorChanged,
                        enableLabel: true,
                      ),
                    ),
                  );
                },
              );
            },
            label:
                const Text('Background', textScaler: TextScaler.linear(0.89)),
            icon: Stack(
              children: [
                Icon(Icons.color_lens, color: currentBackgroundColor),
                // stroke outline around Icon
                const Icon(Icons.color_lens_outlined, color: Colors.black),
              ],
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
