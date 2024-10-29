// shared_controller.dart
import 'package:flutter/material.dart';

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
    carouselController.dispose(); // Dispose when no longer needed
  }
}
