import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text(
            'This is the settings page: change output qr size 200x200, ',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
