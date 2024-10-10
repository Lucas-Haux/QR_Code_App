import 'package:flutter/material.dart';
import 'package:qr_code_app/qrcode_fields.dart';

class MessageField extends StatefulWidget {
  final TextEditingController inputTextController;
  final bool isLinkMessageActive;
  final ValueChanged<bool> onLinkMessageActiveChanged;

  const MessageField({
    Key? key,
    required this.inputTextController,
    required this.isLinkMessageActive,
    required this.onLinkMessageActiveChanged,
  }) : super(key: key);

  @override
  _MessageField createState() => _MessageField();
}

class _MessageField extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Messagetype selector
        SegmentedButton<MessageType>(
          showSelectedIcon: false,
          emptySelectionAllowed: false,
          segments: const [
            ButtonSegment<MessageType>(
              value: MessageType.text,
              label: Text('text'),
            ),
            ButtonSegment<MessageType>(
              value: MessageType.link,
              label: Text('link'),
            ),
            ButtonSegment<MessageType>(
              value: MessageType.wifi,
              label: Text('wifi'),
            ),
          ],
          selected: <MessageType>{selectedMessageType},
          onSelectionChanged: (Set<MessageType> newSelection) {
            setState(
              () {
                selectedMessageType = newSelection.first;

                // if set to Link use onLinkMessageActiveChanged to change isLinkMessageActive
                if (selectedMessageType == MessageType.link) {
                  widget.onLinkMessageActiveChanged(true);
                } else {
                  widget.onLinkMessageActiveChanged(false);
                }
              },
            );
          },
          style: SegmentedButton.styleFrom(
            elevation: 10,
          ),
        ),
        const SizedBox(height: 16),

        // Text TextFields

        // Text inputs
        if (selectedMessageType == MessageType.text)
          SizedBox(
            height: 56,
            width: 300,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                hintText: 'Enter a message',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              controller: widget.inputTextController,
            ),
          )

        // Link TextFields
        else if (selectedMessageType == MessageType.link)
          Column(
            children: [
              SizedBox(
                height: 30,
                child: SegmentedButton(
                  showSelectedIcon: false,
                  emptySelectionAllowed: false,
                  segments: const [
                    ButtonSegment<LinkType>(
                      value: LinkType.http,
                      label: Text(
                        'http',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    ButtonSegment<LinkType>(
                      value: LinkType.https,
                      label: Text(
                        'https',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    ButtonSegment<LinkType>(
                      value: LinkType.raw,
                      label: Text(
                        'raw',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                  selected: <LinkType>{selectedLinkType},
                  onSelectionChanged: (Set<LinkType> newSelection) {
                    setState(
                      () {
                        selectedLinkType = newSelection.first;
                        if (selectedMessageType == MessageType.link) {
                          widget.onLinkMessageActiveChanged(true);
                        }
                      },
                    );
                  },
                  style: SegmentedButton.styleFrom(
                    elevation: 5,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity:
                        const VisualDensity(horizontal: -3, vertical: -3),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Link input field
              SizedBox(
                height: 56,
                width: 300,
                child: TextField(
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
                  controller: widget.inputTextController,
                ),
              ),
            ],
          )
        // Wifi TextFields
        else if (selectedMessageType == MessageType.wifi)
          Column(
            children: [
              // First TextField for WiFi Name (SSID)
              SizedBox(
                height: 56,
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Wi-Fi Name',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Wi-Fi SSID',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  controller: widget.inputTextController,
                ),
              ),
              const SizedBox(height: 10), // Spacing between fields

              // Second TextField for WiFi Password
              SizedBox(
                height: 56,
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true, // Hide password
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Wi-Fi Password',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Wi-Fi password',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  controller: widget.inputTextController,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
