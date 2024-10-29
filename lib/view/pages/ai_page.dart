import 'package:flutter/material.dart';

import 'package:qr_code_generator/view/widgets/ai/ai_inputs/ai_settings.dart';
import 'package:qr_code_generator/view/widgets/ai/ai_inputs/prompts.dart';
import 'package:qr_code_generator/view/widgets/ai/ai_display_and_actions_card.dart';

class AIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('AI QR Code Generator'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AiPrompts(),
              AiSettings(),
              AiDisplayCard(),
            ],
          ),
        ),
      ),
    );
  }
}
