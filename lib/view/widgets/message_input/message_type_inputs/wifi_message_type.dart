import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/wifi_message_type_menu.dart';

class wifiMessageInput extends StatelessWidget {
  const wifiMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First TextField for WiFi Name (SSID)
        SizedBox(
          height: 56,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Wi-Fi Name',
                border: OutlineInputBorder(),
                hintText: 'Enter Wi-Fi SSID',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: inputTextController,
            ),
          ),
        ),
        const SizedBox(height: 10), // Spacing between fields

        // Second TextField for WiFi Password
        SizedBox(
          height: 56,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              textAlign: TextAlign.center,
              obscureText: true, // Hide password
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Wi-Fi Password',
                border: OutlineInputBorder(),
                hintText: 'Enter Wi-Fi password',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: secondaryInputTextController,
              validator: (value) {
                return value.toString().isEmpty
                    ? 'Password Can Not Be Empty'
                    : null;
              },
            ),
          ),
        ),
        const SizedBox(height: 6), // Spacing between field andd menubutton
        const WifiMessageTypeMenu(),
      ],
    );
  }
}
