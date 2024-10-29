import 'package:flutter/material.dart';

import 'package:qr_code_generator/view/widgets/ai/ai_create_button.dart';
import 'package:qr_code_generator/view/widgets/ai/ai_display.dart';
import 'package:qr_code_generator/view/widgets/ai/ai_inputs/ai_settings.dart';
import 'package:qr_code_generator/view/widgets/ai/ai_inputs/prompts.dart';

class AIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('AI QR Code Generator'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const aiPrompts(),
              const AiSettings(),
              Card(
                color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                elevation: 1,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 340, minWidth: 340),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      aiImageDisplay(),
                      AiButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
