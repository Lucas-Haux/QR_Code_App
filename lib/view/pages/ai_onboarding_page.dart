import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:qr_code_generator/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:qr_code_generator/model/inputs_data.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:qr_code_generator/view/widgets/ai/onboarding/onboard_graphics.dart';
import 'package:qr_code_generator/view/widgets/ai/onboarding/aiqr_carousel.dart';
import 'package:qr_code_generator/model/qr_code_data.dart';
import 'package:qr_code_generator/view/widgets/payments.dart';

class AiOnbordingPage extends StatefulWidget {
  const AiOnbordingPage({super.key});

  @override
  State<AiOnbordingPage> createState() => _AiOnbordingPageState();
}

class _AiOnbordingPageState extends State<AiOnbordingPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final carouselController = SharedCarouselController().carouselController;

  final colorizeTextColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = const TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );

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
          SliverToBoxAdapter(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'They All Scan!',
                        colors: colorizeTextColors,
                        textStyle: colorizeTextStyle,
                        speed: const Duration(milliseconds: 500),
                      )
                    ],
                    pause: const Duration(milliseconds: 300),
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),

                  const ShowcaseCarousel(),

                  const SizedBox(height: 10), // spacer

                  SmoothPageIndicator(
                    // indicator
                    controller: carouselController,
                    count: 20,
                    effect: ScrollingDotsEffect(
                      fixedCenter: true,
                      maxVisibleDots: 5,
                      offset: 16.0,
                      dotWidth: 16.0,
                      dotHeight: 16.0,
                      spacing: 8.0,
                      radius: 16,
                      dotColor: Colors.grey,
                      activeDotColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      strokeWidth: 0,
                      activeDotScale: 0,
                      activeStrokeWidth: 0,
                      paintStyle: PaintingStyle.fill,
                    ),
                    onDotClicked: (index) {},
                  ),

                  const SizedBox(height: 30), // spacer
                ],
              ),
            ),
          ),
          // Beer Graphic and info
          const SliverToBoxAdapter(child: Center(child: Graphics())),
          const SliverToBoxAdapter(child: RowProductCards()),
        ],
      ),
    );
  }
}

class RowProductCards extends StatelessWidget {
  const RowProductCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        Text(
          '5 Tokens Per Use of QR Code AI',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            //Left
            SubProductCard(
                title: '90 Tokens',
                tokens: '90 Tokens',
                price: '\$3.50, One Time'),
            //Middle
            MainProductCard(),
            //Right
            SubProductCard(
                title: '1 Month',
                tokens: '280 Tokens!',
                price: '\$10.00 A Month')
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class SubProductCard extends StatelessWidget {
  final String title;
  final String tokens;
  final String price;
  const SubProductCard({
    required this.title,
    required this.tokens,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double aiUses = int.parse(tokens.substring(0, 3)) / 5;
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 0),
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(children: [
          const SizedBox(height: 5),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          // Body
          const SizedBox(height: 10),
          // Tokens and Price
          Text(
            '• $tokens\n• $price',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10),

          // Total AI Uses
          Text('• Only ${aiUses.toInt()} AI Uses'),
          const SizedBox(height: 15),

          // Start Button
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentApp()),
              );
            },
            child: const Text(
              'Start',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10)
        ]),
      ),
    );
  }
}

// trash code, if primary made primary bigger
class MainProductCard extends StatelessWidget {
  const MainProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 0),
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(children: [
          const SizedBox(height: 5),

          // Title
          const Text(
            '2 Months',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          // Body
          const SizedBox(height: 10),
          // Tokens and Price
          const Text(
            '• 500 Tokens\n• \$6 per month\n \n • Only 100 AI Uses',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),

          const SizedBox(height: 15),

          // Start Button
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentApp()),
              );
            },
            child: const Text(
              'Start',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10)
        ]),
      ),
    );
  }
}

void aiPageWarnings() {
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
