import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';

class textMessageInput extends StatelessWidget {
  const textMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 300,
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
            hintText: 'Enter a message',
            floatingLabelAlignment: FloatingLabelAlignment.center,
          ),
          controller: inputTextController,
          validator: (_value) {
            return _value.toString().isEmpty ? 'Name Can Not Be Empty' : null;
          },
        ),
      ),
    );
  }
}
