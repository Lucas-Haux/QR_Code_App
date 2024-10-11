import 'package:flutter/material.dart';

enum MessageType { text, link, wifi, email, contacts }

enum LinkType { http, https, raw }

enum WifiType { wep, wpa, eap, nopass }

// Default Selected item
LinkType selectedLinkType = LinkType.https;
MessageType selectedMessageType = MessageType.text;

WifiType selectedWifiType = WifiType.wpa;

class MessageField extends StatefulWidget {
  final TextEditingController inputTextController;
  final TextEditingController secondaryInputTextController;
  final TextEditingController tertiaryInputTextController;

  const MessageField({
    Key? key,
    required this.inputTextController,
    required this.secondaryInputTextController,
    required this.tertiaryInputTextController,
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
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
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
                  setState(
                    () {
                      selectedMessageType = newSelection.first;
                    },
                  );
                },
                style: SegmentedButton.styleFrom(
                  elevation: 10,
                ),
                expandedInsets: EdgeInsets.all(0),
              ),
            ),
            const SizedBox(height: 16),

            // Text TextFields

            // Text inputs
            if (selectedMessageType == MessageType.text)
              SizedBox(
                height: 56,
                width: 300,
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                      hintText: 'Enter a message',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                    controller: widget.inputTextController,
                    validator: (_value) {
                      return _value.toString().isEmpty
                          ? 'Name Can Not Be Empty'
                          : null;
                    },
                  ),
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

                  const SizedBox(height: 10),
                  // Link input field
                  SizedBox(
                    height: 56,
                    width: 300,
                    child: Form(
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
                              : selectedLinkType.toString().substring(9) +
                                  '://',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                        controller: widget.inputTextController,
                        validator: (_value) {
                          return _value.toString().isEmpty
                              ? 'Link Can Not Be Empty'
                              : null;
                        },
                      ),
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
                        controller: widget.inputTextController,
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
                        controller: widget.secondaryInputTextController,
                        validator: (_value) {
                          return _value.toString().isEmpty
                              ? 'Password Can Not Be Empty'
                              : null;
                        },
                      ),
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
              )
            // Email Text Fields
            else if (selectedMessageType == MessageType.email)
              Column(
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
                        controller: widget.inputTextController,
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
                      controller: widget.secondaryInputTextController,
                    ),
                  ),
                ],
              )
            // Contacts
            else if (selectedMessageType == MessageType.contacts)
              Column(
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
                        controller: widget.inputTextController,
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
                        controller: widget.secondaryInputTextController,
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
                        controller: widget.tertiaryInputTextController,
                        validator: (_value) {
                          return _value.toString().isEmpty
                              ? 'Address Can Not Be Empty'
                              : null;
                        },
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
