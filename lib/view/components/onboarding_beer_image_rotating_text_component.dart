import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class BeerImageRotatingTextComponent extends StatelessWidget {
  const BeerImageRotatingTextComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final rotateTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      color: Theme.of(context).colorScheme.secondaryFixed,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Beer Image
          Container(
            padding: const EdgeInsets.all(25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/aimybeer.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Rotating Text
          SizedBox(
            height: 60,
            width: 360,
            child: AnimatedTextKit(
              animatedTexts: [
                'QR Codes Without Sacrificing Style',
                'No Installation, Works On Any Phone',
                'Artwork In QR Codes Stands Out More',
                'Seamless Scans with Stunning Design',
                'QR Codes as Unique as Your Brand',
                'Customizable and Eye-Catching QR Codes',
                'Instant Access Meets Incredible Art',
                'Beautiful Codes, Effortless Connections',
                'On-Brand, On-Style, On Any Device',
                'Turn Scans into Engagement with AI Style',
              ].map((text) {
                return RotateAnimatedText(
                  text,
                  duration: const Duration(seconds: 3),
                  textStyle: rotateTextStyle,
                  textAlign: TextAlign.center,
                );
              }).toList(),
              pause: const Duration(milliseconds: 500),
              repeatForever: true,
            ),
          ),
        ],
      ),
    );
  }
}
