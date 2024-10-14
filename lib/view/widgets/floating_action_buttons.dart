import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:qr_code_app/view/pages/ai_page.dart';
import 'package:qr_code_app/view/pages/settings_page.dart';

class SettingsAndAIButtons extends StatelessWidget {
  const SettingsAndAIButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Settings Button
        Container(
          padding: const EdgeInsets.all(18),
          child: FloatingActionButton.small(
            // Navigate to settings page
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            heroTag: 'settings',
            child: const Icon(Icons.settings),
          ),
        ),
        const Spacer(),
        // AI Button
        Container(
          padding: const EdgeInsets.all(18),
          child: FloatingActionButton.small(
            onPressed: () {
              // Navigate to AI page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AIPage()),
              );
            },
            heroTag: 'ai',
            child: const Icon(CupertinoIcons.sparkles),
          ),
        ),
      ],
    );
  }
}
