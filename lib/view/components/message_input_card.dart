import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_generator/model/qrcode_message_enums.dart';
import 'package:qr_code_generator/view/widgets/input_form_widget.dart';

class MessageInputCard extends StatelessWidget {
  final ValueNotifier<MessageType> messageTypeNotifier;
  final void Function(MessageType) setMessageType;
  final ValueNotifier linkTypeNotifier;
  final void Function(LinkType) setLinkType;
  final TextEditingController firstController;
  final TextEditingController secondController;
  final TextEditingController thirdController;
  final void Function(WifiType) setWifiType;
  final ValueNotifier<WifiType> wifiTypeNotifier;

  const MessageInputCard({
    required this.wifiTypeNotifier,
    required this.messageTypeNotifier,
    required this.setWifiType,
    required this.linkTypeNotifier,
    required this.setLinkType,
    required this.setMessageType,
    required this.firstController,
    required this.secondController,
    required this.thirdController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Select Message Type
              _MessageTypeSelector(
                messageTypeNotifier: messageTypeNotifier,
                setMessageType: setMessageType,
              ),
              const SizedBox(height: 10),
              // Show Message Forms based on Message Type
              ValueListenableBuilder<MessageType>(
                valueListenable: messageTypeNotifier,
                builder: (context, selectedMessageType, child) {
                  Widget child;
                  switch (selectedMessageType) {
                    case MessageType.text:
                      child = InputForm(
                        labelText: 'Message',
                        hintText: 'Enter a Message',
                        textController: firstController,
                      );
                    case MessageType.link:
                      child = _LinkMessage(
                        firstTextController: firstController,
                        linkTypeNotifier: linkTypeNotifier,
                        setLinkType: setLinkType,
                      );
                    case MessageType.wifi:
                      child = _WifiMessage(
                        firstController: firstController,
                        secondController: secondController,
                        setWifiType: setWifiType,
                        wifiTypeNotifier: wifiTypeNotifier,
                      );
                    case MessageType.email:
                      child = _EmailMessage(
                        firstController: firstController,
                        secondController: secondController,
                      );
                    case MessageType.contacts:
                      child = _ContactsMessage(
                        secondController: secondController,
                        firstController: firstController,
                        thirdController: thirdController,
                      );
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: child,
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

class _MessageTypeSelector extends StatelessWidget {
  final ValueNotifier messageTypeNotifier;
  final void Function(MessageType) setMessageType;

  const _MessageTypeSelector({
    required this.messageTypeNotifier,
    required this.setMessageType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ValueListenableBuilder(
        valueListenable: messageTypeNotifier,
        builder: (context, selectedMessageType, child) {
          return SegmentedButton<MessageType>(
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
            selected: {selectedMessageType},
            onSelectionChanged: (Set<MessageType> newSelection) {
              selectedMessageType = newSelection.first;
              setMessageType(newSelection.first);
            },
            style: SegmentedButton.styleFrom(
              elevation: 10,
            ),
            expandedInsets: const EdgeInsets.all(0),
          );
        },
      ),
    );
  }
}

class _LinkMessage extends StatelessWidget {
  final ValueNotifier linkTypeNotifier;
  final void Function(LinkType) setLinkType;
  final TextEditingController firstTextController;
  const _LinkMessage({
    required this.linkTypeNotifier,
    required this.setLinkType,
    required this.firstTextController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: linkTypeNotifier,
      builder: (context, selectedLinkType, child) {
        return Column(
          children: [
            // Link button
            SizedBox(
              height: 30,
              child: SegmentedButton(
                showSelectedIcon: false,
                emptySelectionAllowed: false,
                segments: const [
                  ButtonSegment<LinkType>(
                    value: LinkType.http,
                    label: Text(
                      'Http',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  ButtonSegment<LinkType>(
                    value: LinkType.https,
                    label: Text(
                      'Https',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  ButtonSegment<LinkType>(
                    value: LinkType.raw,
                    label: Text(
                      'Raw',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
                selected: <LinkType>{selectedLinkType},
                onSelectionChanged: (Set<LinkType> newSelection) {
                  selectedLinkType = newSelection.first;
                  setLinkType(newSelection.first);
                },
                style: SegmentedButton.styleFrom(
                  elevation: 5,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      const VisualDensity(horizontal: -3, vertical: -3),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InputForm(
              labelText: 'URL',
              hintText: 'Enter URL',
              textAlignment: selectedLinkType == LinkType.raw
                  ? TextAlign.center
                  : TextAlign.left,
              keyboardType: TextInputType.url,
              prefixText: selectedLinkType == LinkType.raw
                  ? ''
                  : '${selectedLinkType.toString().substring(9)}://',
              textController: firstTextController,
            )
          ],
        );
      },
    );
  }
}

class _WifiMessage extends StatelessWidget {
  final ValueNotifier wifiTypeNotifier;
  final void Function(WifiType) setWifiType;
  final TextEditingController firstController;
  final TextEditingController secondController;

  const _WifiMessage({
    required this.setWifiType,
    required this.wifiTypeNotifier,
    required this.firstController,
    required this.secondController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: wifiTypeNotifier,
          builder: (context, selectedWifiType, child) {
            return MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () => setWifiType(WifiType.wep),
                  child: const Text('WEP'),
                ),
                MenuItemButton(
                  onPressed: () => setWifiType(WifiType.wpa),
                  child: const Text('WPA/WPA2'),
                ),
                MenuItemButton(
                  onPressed: () => setWifiType(WifiType.eap),
                  child: const Text('WPA2-EAP'),
                ),
                MenuItemButton(
                  onPressed: () => setWifiType(WifiType.nopass),
                  child: const Text('No Password/Encryption'),
                ),
              ],
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return OutlinedButton(
                  // focusNode: _buttonFocusNode,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                      'Encryption Type:  ${selectedWifiType.toString().substring(9).toUpperCase()}'),
                );
              },
              style:
                  const MenuStyle(alignment: AlignmentDirectional.bottomStart),
            );
          },
        ),
        InputForm(
          labelText: 'Wi-Fi Name',
          hintText: 'Enter Wifi SSID',
          textController: firstController,
        ),
        const SizedBox(height: 15),
        InputForm(
          labelText: 'Wi-Fi Password',
          hintText: 'Enter Wi-Fi Password',
          textController: secondController,
        )
      ],
    );
  }
}

class _EmailMessage extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;

  const _EmailMessage({
    required this.firstController,
    required this.secondController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputForm(
          labelText: 'Email Address',
          hintText: 'Enter Email Address',
          textController: firstController,
        ),
        const SizedBox(height: 15),
        InputForm(
          labelText: 'Email Subject',
          hintText: 'Enter Email Subject',
          textController: secondController,
          opitional: true,
        )
      ],
    );
  }
}

class _ContactsMessage extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final TextEditingController thirdController;
  const _ContactsMessage({
    required this.secondController,
    required this.firstController,
    required this.thirdController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputForm(
            labelText: 'Name',
            hintText: 'Enter Contact Name',
            textController: firstController,
            keyboardType: TextInputType.name),
        const SizedBox(height: 10),
        InputForm(
          labelText: 'Phone Number',
          hintText: 'Enter Phone Number',
          textController: secondController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        InputForm(
          labelText: 'Address',
          hintText: 'Enter Contact Adress',
          textController: thirdController,
          keyboardType: TextInputType.streetAddress,
          opitional: true,
        ),
      ],
    );
  }
}
