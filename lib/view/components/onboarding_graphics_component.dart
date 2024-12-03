import 'package:flutter/material.dart';

class OnboardInfoCards extends StatelessWidget {
  const OnboardInfoCards({super.key});

  Widget buildCard(
      BuildContext context, String title, String description, int index) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(25),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: '$index. $title\n\n',
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
              TextSpan(
                text: description,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCard(
          context,
          'Enhanced Aesthetics',
          'Traditional QR codes often disrupt the design flow of packaging and branding materials. '
              'With AI-generated QR code art, you can seamlessly blend functionality with creativity. '
              'QR codes can now be integrated into stunning, visually engaging designs that align with your brand’s identity.',
          1,
        ),
        buildCard(
          context,
          'Increased Engagement',
          'By using customized, eye-catching QR codes, you turn a simple scan into a memorable brand experience. '
              'These codes pique curiosity and encourage interaction, driving more customers to scan and connect with your digital content.',
          2,
        ),
        buildCard(
          context,
          'Flexible Design',
          'AI-generated QR codes are adaptable to any style. From artistic illustrations to product-themed designs, '
              'you can tailor QR codes to fit different campaigns or seasons, enhancing your marketing flexibility. '
              'This innovation is perfect for product packaging, posters, business cards, or in-store displays.',
          3,
        ),
      ],
    );
  }
}
