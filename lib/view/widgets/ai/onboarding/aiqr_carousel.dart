import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:qr_code_generator/view/widgets/ai/onboarding/shared_controller.dart';

class carouselQR extends StatefulWidget {
  carouselQR({super.key});

  @override
  State<carouselQR> createState() => _carouselQRState();
}

class _carouselQRState extends State<carouselQR> {
  late final PageController carouselController =
      PageController(initialPage: 10);

  @override
// Start at index 10

  Widget build(BuildContext context) {
    final controller = SharedCarouselController()
        .carouselController; // Get the shared controller

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
        child: PageView.builder(
          controller: controller, // Use the PageController
          pageSnapping: false,
          dragStartBehavior: DragStartBehavior.start,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          allowImplicitScrolling: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return UncontainedLayoutCard(index: index);
          },
        ),
      ),
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(35.0), // Adjust the radius as needed
        child: Container(
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/qrImages/qr$index.png', // Replace with the actual asset path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
