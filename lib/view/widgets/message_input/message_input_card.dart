import 'package:flutter/material.dart';

import 'package:qr_code_app/model/inputs_data.dart';
import 'package:qr_code_app/view/widgets/message_input/message_input_button.dart';
import 'package:qr_code_app/view/widgets/message_input/message_type_inputs/text_message_type.dart';
import 'package:qr_code_app/view/widgets/message_input/message_type_inputs/link_message_type.dart';
import 'package:qr_code_app/view/widgets/message_input/message_type_inputs/wifi_message_type.dart';
import 'package:qr_code_app/view/widgets/message_input/message_type_inputs/email_message_type.dart';
import 'package:qr_code_app/view/widgets/message_input/message_type_inputs/contacts_message_type.dart';

class MessageInputCard extends StatelessWidget {
  final ValueNotifier<MessageType> messageTypeNotifier =
      ValueNotifier<MessageType>(MessageType.link);

  MessageInputCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MessageSelectorButton(messageTypeNotifier: messageTypeNotifier),
            const SizedBox(height: 16),
            ValueListenableBuilder<MessageType>(
              valueListenable: messageTypeNotifier,
              builder: (context, qrCodeImage, child) {
                return switch (selectedMessageType) {
                  MessageType.text => textMessageInput(),
                  MessageType.link => linkMessageInput(),
                  MessageType.wifi => wifiMessageInput(),
                  MessageType.email => emailMessageInput(),
                  MessageType.contacts => contactsMessageInput(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
