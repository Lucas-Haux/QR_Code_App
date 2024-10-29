import 'package:flutter/material.dart';

import 'package:qr_code_generator/view/pages/ai_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:qr_code_generator/view/widgets/ai/onboarding/onboard_graphics.dart';
import 'package:qr_code_generator/view/widgets/ai/onboarding/aiqr_carousel.dart';

class AiOnbordingPage extends StatefulWidget {
  const AiOnbordingPage({super.key});

  @override
  State<AiOnbordingPage> createState() => _AiOnbordingPageState();
}

class _AiOnbordingPageState extends State<AiOnbordingPage> {
  final controller = SharedCarouselController()
      .carouselController; // Get the shared controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AIPage()),
                    );
                  },
                  child: const Text('sign in with google to start')),
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
                  RichText(
                    text: TextSpan(
                      text: 'They All Scan!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryFixed,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const ShowcaseCarousel(),

                  const SizedBox(height: 10), // spacer

                  SmoothPageIndicator(
                    // indicator
                    controller: controller,
                    count: 20,
                    effect: const ScrollingDotsEffect(
                      fixedCenter: true,
                      maxVisibleDots: 5,
                      offset: 16.0,
                      dotWidth: 16.0,
                      dotHeight: 16.0,
                      spacing: 8.0,
                      radius: 16,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.indigo,
                      strokeWidth: 0,
                      activeDotScale: 0,
                      paintStyle: PaintingStyle.fill,
                    ),
                    onDotClicked: (index) {},
                  ),

                  const SizedBox(height: 30), // spacer
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(
              child: Graphics(), // Beer Graphic and info
            ),
          ),
        ],
      ),
    );
  }
}
