import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child:
            Text('This is the settings page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
