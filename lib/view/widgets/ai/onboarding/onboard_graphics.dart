import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Graphics extends StatelessWidget {
  const Graphics({super.key});

  @override
  Widget build(BuildContext context) {
    final rotateTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      color: Theme.of(context).colorScheme.secondaryFixed,
    );
    return Column(
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
              RotateAnimatedText(
                'QR Codes Without Sacrificing Style',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'No Installation, Works On Any Phone',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'Artwork In QR Codes Stands Out More',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'Seamless Scans with Stunning Design',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'QR Codes as Unique as Your Brand',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'Customizable and Eye-Catching QR Codes',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'Instant Access Meets Incredible Art',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'Beautiful Codes, Effortless Connections',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'On-Brand, On-Style, On Any Device',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
              RotateAnimatedText(
                'Turn Scans into Engagement with AI Style',
                duration: const Duration(seconds: 3),
                textStyle: rotateTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
            pause: const Duration(milliseconds: 500),
            repeatForever: true,
          ),
        ),

        // Card 1
        Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          elevation: 1,
          margin: const EdgeInsets.all(25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(25),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  // Title 1
                  TextSpan(
                    text: '1. Enhanced Aesthetics \n\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(
                          const Rect.fromLTWH(0, 0, 200, 30),
                        ),
                      height: 1,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'Traditional QR codes often disrupt the design flow of packaging and branding materials. '
                        'With AI-generated QR code art, you can seamlessly blend functionality with creativity. '
                        'QR codes can now be integrated into stunning, visually engaging designs that align with your brand’s identity.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Card 2
        Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          elevation: 1,
          margin: const EdgeInsets.all(25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(25),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  // Title 2
                  TextSpan(
                    text: '2. Increased Engagement\n\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(
                          const Rect.fromLTWH(0, 0, 200, 30),
                        ),
                      height: 1,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'By using customized, eye-catching QR codes, you turn a simple scan into a memorable brand experience. '
                        'These codes pique curiosity and encourage interaction, driving more customers to scan and connect with your digital content.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Card 3
        Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          elevation: 1,
          margin: const EdgeInsets.all(25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            constraints: const BoxConstraints(minWidth: 360, maxWidth: 360),
            padding: const EdgeInsets.all(25),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  // Title 3
                  TextSpan(
                    text: '3. Flexible Design\n\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(
                          const Rect.fromLTWH(0, 0, 200, 30),
                        ),
                      height: 1,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'AI-generated QR codes are adaptable to any style. From artistic illustrations to product-themed designs, '
                        'you can tailor QR codes to fit different campaigns or seasons, enhancing your marketing flexibility. '
                        'This innovation is perfect for product packaging, posters, business cards, or in-store displays.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
