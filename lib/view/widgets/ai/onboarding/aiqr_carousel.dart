import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShowcaseCarousel extends StatefulWidget {
  const ShowcaseCarousel({super.key});

  @override
  State<ShowcaseCarousel> createState() => _ShowcaseCarouselState();
}

class _ShowcaseCarouselState extends State<ShowcaseCarousel> {
  late final PageController carouselController =
      PageController(initialPage: 10);

  @override
  Widget build(BuildContext context) {
    final controller = SharedCarouselController().carouselController;
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
          controller: controller,
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

class SharedCarouselController {
  static final SharedCarouselController _instance =
      SharedCarouselController._internal();

  factory SharedCarouselController() {
    return _instance;
  }

  SharedCarouselController._internal();

  late final PageController carouselController =
      PageController(initialPage: 10, viewportFraction: 1 / 2);

  void dispose() {
    carouselController.dispose();
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
      padding: const EdgeInsets.all(10),
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
