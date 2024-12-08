import 'package:flutter/material.dart';

// shows image of qrcode once notified
class ImageDisplay extends StatelessWidget {
  final ValueNotifier<String> qrcodeImageUrlNotifier;
  final ValueNotifier<bool> loadingNotifier;
  const ImageDisplay({
    required this.qrcodeImageUrlNotifier,
    required this.loadingNotifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: qrcodeImageUrlNotifier,
      builder: (context, qrCodeImage, child) {
        return qrCodeImage.isNotEmpty
            ? Container(
                height: 250,
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 250),
                padding: const EdgeInsets.only(bottom: 30),
                child: Image.network(
                  qrCodeImage, // Display the QR code
                ),
              )
            : ValueListenableBuilder<bool>(
                valueListenable: loadingNotifier,
                builder: (context, loadState, child) {
                  return loadState == true
                      ? Container(
                          constraints: const BoxConstraints(
                              maxWidth: 300, maxHeight: 250),
                          padding: const EdgeInsets.only(bottom: 30),
                          child: const CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink();
                },
              );
      },
    );
  }
}
