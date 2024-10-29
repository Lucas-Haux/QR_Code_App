import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';

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
     print('messagetype update $selectedMessageType');
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
