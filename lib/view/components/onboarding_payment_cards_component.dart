import 'package:flutter/material.dart';

class RowProductCards extends StatelessWidget {
  final VoidCallback buy90Tokens;

  const RowProductCards({required this.buy90Tokens, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          '5 Tokens Per Use of QR Code AI',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            //Left
            const _SubProductCard(
                title: '90 Tokens',
                tokens: '90 Tokens',
                price: '\$3.50, One Time'),
            //Middle
            _MainProductCard(buy90Tokens: buy90Tokens),
            //Right
            const _SubProductCard(
                title: '1 Month',
                tokens: '280 Tokens!',
                price: '\$10.00 A Month')
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SubProductCard extends StatelessWidget {
  final String title;
  final String tokens;
  final String price;
  const _SubProductCard({
    required this.title,
    required this.tokens,
    required this.price,
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
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {},
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

class _MainProductCard extends StatelessWidget {
  final VoidCallback buy90Tokens;
  const _MainProductCard({required this.buy90Tokens});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
    );

    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 30, top: 0),
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
          Text(
            '• 500 Tokens\n• \$6 per month\n \n • 100 AI Uses',
            style: bodyStyle,
          ),

          const SizedBox(height: 15),

          // Start Button
          FilledButton(
            onPressed: buy90Tokens,
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
