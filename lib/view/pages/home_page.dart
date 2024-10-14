import 'package:flutter/material.dart';

import 'package:qr_code_app/view/widgets/floating_action_buttons.dart';
import 'package:qr_code_app/view/widgets/qr_display_and_buttons/qr_code_display_and_actions_card.dart';
import 'package:qr_code_app/view/widgets/error_correction_and_colors_card/error_correction_inputs.dart';
import 'package:qr_code_app/view/widgets/message_input/message_input_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Input Fields for the QRcode Message
              MessageInputCard(),

              const ErrorCorrectionsAndColorCard(),
              // Display QR Code and buttons card
              DisplayAndActionsCard(),

              const Spacer(),
            ],
          ),
          const Column(
            children: [
              Spacer(),
              SettingsAndAIButtons(), // Row with Two floating buttons taking you to settings/ai page
            ],
          ),
        ],
      ),
    );
  }
}
