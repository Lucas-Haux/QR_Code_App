import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';

class contactsMessageInput extends StatelessWidget {
  const contactsMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // name
        SizedBox(
          height: 56,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: inputTextController,
              validator: (_value) {
                return _value.toString().isEmpty
                    ? 'Name Can Not Be Empty'
                    : null;
              },
            ),
          ),
        ),
        const SizedBox(height: 10), // Spacing between fields
        // Phone
        SizedBox(
          height: 56,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                hintText: 'Enter Phone Number',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: secondaryInputTextController,
              validator: (value) {
                // Validate if the phone number is empty or not a valid number
                if (value == null || value.isEmpty) {
                  return 'Phone Number Can Not Be Empty';
                }
                // Check if the input consists only of digits
                final RegExp numberRegExp = RegExp(r'^[0-9]+$');
                if (!numberRegExp.hasMatch(value)) {
                  return 'Phone Number Must Be Numeric';
                }
                return null; // No validation error
              },
            ),
          ),
        ),
        const SizedBox(height: 10), // Spacing between fields
        // Address
        SizedBox(
          height: 56,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                hintText: 'Enter Address',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: tertiaryInputTextController,
              validator: (_value) {
                return _value.toString().isEmpty
                    ? 'Address Can Not Be Empty'
                    : null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
