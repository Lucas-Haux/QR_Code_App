import 'package:flutter/material.dart';

import 'package:qr_code_generator/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:qr_code_generator/model/inputs_data.dart';
import 'package:qr_code_generator/view/components/onboarding_carousel_component.dart';

import 'package:qr_code_generator/view/components/onboarding_beer_image_rotating_text_component.dart';
import 'package:qr_code_generator/view/components/onboarding_graphics_component.dart';
import 'package:qr_code_generator/model/qr_code_data.dart';
import 'package:qr_code_generator/view/components/onboarding_payment_cards_component.dart';
import 'package:qr_code_generator/view/pages/ai_page.dart';
import 'package:qr_code_generator/viewModel/onboarding_viewmodel.dart';

class AiOnbordingPage extends StatefulWidget {
  const AiOnbordingPage({super.key});

  @override
  State<AiOnbordingPage> createState() => _AiOnbordingPageState();
}

class _AiOnbordingPageState extends State<AiOnbordingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    OnboardingViewmodel().initialize();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: FilledButton(
                  onPressed: () {
                    _scrollToBottom();
                  },
                  child: const Text('Pay To Access AI Feature')),
              centerTitle: true,
            ),
          ),

          // carousel
          const SliverToBoxAdapter(child: OnboardingCarouselComponent()),
          // beer graphic and rotating text
          const SliverToBoxAdapter(child: BeerImageRotatingTextComponent()),
          // info cards
          const SliverToBoxAdapter(child: OnboardInfoCards()),
          // Product Cards
          SliverToBoxAdapter(
              child: RowProductCards(
                  buy90Tokens: OnboardingViewmodel().buy90Tokens)),
          SliverToBoxAdapter(
              child: FilledButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AIPage())),
                  child: Text('take me to ai')))
        ],
      ),
    );
  }
}

void _aiPageWarnings() {
  if (usedErrorCorrectionLevel != ErrorCorrectionLevel.H) {
    SnackBarManager.showSnackBar(
      'AI Generator Warning',
      'Error Correction Level isnt set to High. This could make the QR Code harder to scan.',
      ContentType.warning,
    );
  }

  if (usedForgroundColor.value != 4278190080) {
    SnackBarManager.showSnackBar(
      'AI Generator Warning',
      'Forground color isnt Black. This could result in failures. Current color = #${usedForgroundColor.value.toRadixString(16).toString().substring(2).toUpperCase()}',
      ContentType.warning,
    );
  }
  if (usedBackgroundColor.value != 4294967295) {
    SnackBarManager.showSnackBar(
      'AI Generator Warning',
      'Background color isnt white. This could result in failures. Current color = #${usedBackgroundColor.value.toRadixString(16).toString().substring(2).toUpperCase()}',
      ContentType.warning,
    );
  }
}
