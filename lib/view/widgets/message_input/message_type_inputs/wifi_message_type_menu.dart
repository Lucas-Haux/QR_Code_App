import 'package:flutter/material.dart';

import 'package:qr_code_app/model/inputs_data.dart';

class WifiMessageTypeMenu extends StatefulWidget {
  const WifiMessageTypeMenu({super.key});

  @override
  State<WifiMessageTypeMenu> createState() => _WifiMessageTypeMenuState();
}

class _WifiMessageTypeMenuState extends State<WifiMessageTypeMenu> {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
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
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return OutlinedButton(
            // focusNode: _buttonFocusNode,
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            child: Text('Encryption Type: ' +
                selectedWifiType.toString().substring(9).toUpperCase()),
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))));
      },
      style: MenuStyle(alignment: AlignmentDirectional.bottomStart),
    );
  }
}
