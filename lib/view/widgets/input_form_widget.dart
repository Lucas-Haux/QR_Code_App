import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? prefixText;
  final TextEditingController textController;
  final TextAlign? textAlignment;
  final TextInputType? keyboardType;
  final bool? opitional;
  const InputForm({
    this.opitional,
    this.textAlignment,
    this.keyboardType,
    this.prefixText,
    required this.labelText,
    required this.hintText,
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        autovalidateMode: opitional == true
            ? AutovalidateMode.disabled
            : AutovalidateMode.always,
        child: TextFormField(
          textAlign: textAlignment ?? TextAlign.center,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            hintText: hintText,
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            prefixText: prefixText,
            prefixStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller: textController,
          validator: (value) {
            return value.toString().isEmpty ? 'Field Can Not Be Empty' : null;
          },
        ),
      ),
    );
  }
}
