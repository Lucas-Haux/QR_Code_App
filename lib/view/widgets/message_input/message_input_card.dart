import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/text_message_type.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/link_message_type.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/wifi_message_type.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/email_message_type.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_type_inputs/contacts_message_type.dart';

class MessageInputCard extends StatelessWidget {
  const MessageInputCard({super.key});

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
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MessageSelectorButton(messageTypeNotifier: messageTypeNotifier),
              const SizedBox(height: 16),
              ValueListenableBuilder<MessageType>(
                valueListenable: messageTypeNotifier,
                builder: (context, qrCodeImage, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: switch (selectedMessageType) {
                      MessageType.text => const TextMessageInput(),
                      MessageType.link => const LinkMessageInput(),
                      MessageType.wifi => const WifiMessageInput(),
                      MessageType.email => const EmailMessageInput(),
                      MessageType.contacts => const ContactsMessageInput(),
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageSelectorButton extends StatefulWidget {
  final ValueNotifier<MessageType> messageTypeNotifier;
  const MessageSelectorButton({super.key, required this.messageTypeNotifier});

  @override
  State<MessageSelectorButton> createState() => _MessageSelectorButtonState();
}

class _MessageSelectorButtonState extends State<MessageSelectorButton> {
  void updateMessageType(MessageType newType) {
    setState(() {
      selectedMessageType = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: SegmentedButton<MessageType>(
        showSelectedIcon: false,
        emptySelectionAllowed: false,
        segments: const [
          ButtonSegment<MessageType>(
            value: MessageType.text,
            label: Text('Text', style: TextStyle(fontSize: 10)),
          ),
          ButtonSegment<MessageType>(
            value: MessageType.link,
            label: Text('Link', style: TextStyle(fontSize: 10)),
          ),
          ButtonSegment<MessageType>(
            value: MessageType.wifi,
            label: Text('Wifi', style: TextStyle(fontSize: 10)),
          ),
          ButtonSegment<MessageType>(
            value: MessageType.email,
            label: Text('Email', style: TextStyle(fontSize: 10)),
          ),
          ButtonSegment(
            value: MessageType.contacts,
            label: Text('Contact', style: TextStyle(fontSize: 10)),
          ),
        ],
        selected: <MessageType>{selectedMessageType},
        onSelectionChanged: (Set<MessageType> newSelection) {
          updateMessageType(newSelection.first);
          widget.messageTypeNotifier.value = newSelection.first;
        },
        style: SegmentedButton.styleFrom(
          elevation: 10,
        ),
        expandedInsets: const EdgeInsets.all(0),
      ),
    );
  }
}
