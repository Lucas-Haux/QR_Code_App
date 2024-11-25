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
          const SliverToBoxAdapter(child: ProductCards()),
        ],
      ),
    );
  }
}

class ProductCards extends StatelessWidget {
  const ProductCards({super.key});

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
            ProductCard(
                primary: false,
                title: '90 Tokens',
                tokens: '90 Tokens',
                price: '\$3.50, One Time'),
            ProductCard(
                primary: true,
                title: '2 Months',
                tokens: '500 Tokens!',
                price: '\$6.00 A Month!'),
            ProductCard(
                primary: false,
                title: '1 Month',
                tokens: '280 Tokens!',
                price: '\$10.00 A Month')
          ],
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String tokens;
  final String price;
  final bool primary;
  const ProductCard({
    required this.title,
    required this.tokens,
    required this.price,
    required this.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double aiUses = int.parse(tokens.substring(0, 3)) / 5;
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(
            left: 5, right: 5, bottom: primary ? 0 : 40, top: primary ? 0 : 13),
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(children: [
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primary
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '• $tokens\n• $price',
            style: TextStyle(
              fontSize: 15,
              fontWeight: primary ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (aiUses == 18) ...[
            const SizedBox(height: 10),
            Text('• Only ${aiUses.toInt()} AI Uses'),
            const SizedBox(height: 15),
          ] else if (aiUses < 90)
            const SizedBox(height: 45),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20)
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
