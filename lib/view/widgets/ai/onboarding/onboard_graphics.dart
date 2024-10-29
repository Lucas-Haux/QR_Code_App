import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class graphics extends StatelessWidget {
  const graphics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        // Card 1
        Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          elevation: 1,
          margin: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(25),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  // Title 1
                  TextSpan(
                    text: '1. Enhanced Aesthetics \n\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      height: 1,
                    ),
                  ),
                  TextSpan(
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

        // Spacer

        // Card 2
        Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          elevation: 1,
          margin: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(25),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  // Title 2
                  TextSpan(
                    text: '2. Increased Engagement\n\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      height: 1,
                    ),
                  ),
                  TextSpan(
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

        // Spacer

        // Card 3
        Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          elevation: 1,
          margin: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 360, maxWidth: 360),
            padding: const EdgeInsets.all(25),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: <TextSpan>[
                  // Title 3
                  TextSpan(
                    text: '3. Flexible Design\n\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      height: 1,
                    ),
                  ),
                  TextSpan(
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
