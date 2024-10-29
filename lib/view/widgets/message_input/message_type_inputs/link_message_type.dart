import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/link_message_type_button.dart';

class linkMessageInput extends StatelessWidget {
  const linkMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LinkButton(),

        const SizedBox(height: 10),
        // Link input field
        SizedBox(
          height: 56,
          width: 300,
          child: ValueListenableBuilder<LinkType>(
            valueListenable: linkTypeNotifier,
            builder: (context, selectedLinkType, child) {
              return Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  textAlign: selectedLinkType == LinkType.raw
                      ? TextAlign.center
                      : TextAlign.left,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: 'URL',
                    border: const OutlineInputBorder(),
                    hintText: 'Enter URL',
                    hintStyle: const TextStyle(fontSize: 16),
                    prefixStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixText: selectedLinkType == LinkType.raw
                        ? ''
                        : selectedLinkType.toString().substring(9) + '://',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  controller: inputTextController,
                  validator: (_value) {
                    return _value.toString().isEmpty
                        ? 'Link Can Not Be Empty'
                        : null;
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
