import 'package:flutter/material.dart';

class price_and_signin_card extends StatelessWidget {
  const price_and_signin_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 250),
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              'Use QR Codes Without Sacrificing Style',
              textAlign: TextAlign.center,
              maxLines: 2, // Limit to two lines
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                print('works');
              },
              child: Text('Sign in with google'),
            ),
            Spacer(),
            RichText(
              text: TextSpan(
                text: 'Starting At ', // Default color or style for this part
                style: TextStyle(fontSize: 19),
                children: <TextSpan>[
                  TextSpan(
                    text: '\$10',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        fontSize: 19,
                        fontWeight:
                            FontWeight.bold), // Green and bold for the price
                  ),
                  TextSpan(
                    text: '/month',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
