import 'package:flutter/material.dart';

enum MessageType { text, link, wifi }

enum LinkType { http, https, raw }

enum WifiType { wep, wpa, eap, nopass }

// Default Selected item
LinkType selectedLinkType = LinkType.https;
MessageType selectedMessageType = MessageType.text;

WifiType selectedWifiType = WifiType.wpa;

class MessageField extends StatefulWidget {
  final TextEditingController inputTextController;
  final TextEditingController secondaryInputTextController;

  const MessageField({
    Key? key,
    required this.inputTextController,
    required this.secondaryInputTextController,
  }) : super(key: key);

  @override
  MessageFieldState createState() => MessageFieldState();
}

class MessageFieldState extends State<MessageField> {
  final FocusNode _buttonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(), // empty row will make all three cards in home_page the same size
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
                      controller: widget.secondaryInputTextController,
                    ),
                  ),
                  const SizedBox(
                      height: 6), // Spacing between field andd menubutton
                  //
                  MenuAnchor(
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {
                          setState(() {
                            selectedWifiType = WifiType.wep;
                          });
                        },
                        child: const Text('WEP'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          setState(() {
                            selectedWifiType = WifiType.wpa;
                          });
                        },
                        child: const Text('WPA/WPA2'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          setState(() {
                            selectedWifiType = WifiType.eap;
                          });
                        },
                        child: const Text('WPA2-EAP'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          setState(() {
                            selectedWifiType = WifiType.nopass;
                          });
                        },
                        child: const Text('No Password/Encryption'),
                      ),
                    ],
                    builder: (BuildContext context, MenuController controller,
                        Widget? child) {
                      return OutlinedButton(
                          focusNode: _buttonFocusNode,
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: Text('Encryption Type: ' +
                              selectedWifiType
                                  .toString()
                                  .substring(9)
                                  .toUpperCase()),
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))));
                    },
                    style:
                        MenuStyle(alignment: AlignmentDirectional.bottomStart),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
