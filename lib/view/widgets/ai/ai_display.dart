import 'package:flutter/material.dart';

import 'package:qr_code_generator/model/ai_image_data.dart';

class aiImageDisplay extends StatelessWidget {
  const aiImageDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: aiNotifier,
      builder: (context, aiImage, child) {
        return aiImage.isNotEmpty
            ? Container(
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 291),
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Image.network(
                      aiImage, // Display the QR code

                      scale: 2,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        return Center(child: child);
                      },
                    ),
                  ],
                ))
            : const SizedBox.shrink(); // Show no space if no QR code
      },
    );
  }
}
