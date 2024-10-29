import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/inputs_data.dart';

class LinkButton extends StatefulWidget {
  const LinkButton({super.key});

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

ValueNotifier<LinkType> linkTypeNotifier =
    ValueNotifier<LinkType>(LinkType.https);

class _LinkButtonState extends State<LinkButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              linkTypeNotifier.value = newSelection.first;
            },
          );
        },
        style: SegmentedButton.styleFrom(
          elevation: 5,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        ),
      ),
    );
  }
}
