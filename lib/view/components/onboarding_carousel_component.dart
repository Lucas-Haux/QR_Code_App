import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingCarouselComponent extends StatelessWidget {
  const OnboardingCarouselComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final carouselController = _CarouselController().carouselController;

    final colorizeTextColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold,
    );

    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated "They All Scan" Text
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

          // AI Qrcode Carousel
          _AiQrcodeCarousel(),

          const SizedBox(height: 10), // spacer

          // carousel indicator
          SmoothPageIndicator(
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
              activeDotColor: Theme.of(context).colorScheme.inversePrimary,
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
    );
  }
}

class _AiQrcodeCarousel extends StatelessWidget {
  late final PageController carouselController =
      PageController(initialPage: 10);

  @override
  Widget build(BuildContext context) {
    final controller = _CarouselController().carouselController;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: [0.0, 0.1, 0.9, 1],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,

        // carousel
        child: PageView.builder(
          controller: controller,
          pageSnapping: false,
          dragStartBehavior: DragStartBehavior.start,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          allowImplicitScrolling: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return _AiQrcodeImage(index: index);
          },
        ),
      ),
    );
  }
}

class _AiQrcodeImage extends StatelessWidget {
  const _AiQrcodeImage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35.0),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/qrImages/qr$index.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _CarouselController {
  static final _CarouselController _instance = _CarouselController._internal();

  factory _CarouselController() {
    return _instance;
  }

  _CarouselController._internal();

  late final PageController carouselController =
      PageController(initialPage: 10, viewportFraction: 1 / 2);
}
