import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';

class emailMessageInput extends StatelessWidget {
  const emailMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Address
        SizedBox(
          height: 56,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                hintText: 'Enter Address',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: inputTextController,
              validator: (_value) {
                return _value.toString().isEmpty
                    ? 'Address Can Not Be Empty'
                    : null;
              },
            ),
          ),
        ),
        const SizedBox(height: 10), // Spacing between fields
        // Subject
        SizedBox(
          height: 56,
          width: 300,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Email Subject',
              border: OutlineInputBorder(),
              hintText: 'Optional Subject',
              floatingLabelAlignment: FloatingLabelAlignment.center,
            ),
            controller: secondaryInputTextController,
          ),
        ),
      ],
    );
  }
}
