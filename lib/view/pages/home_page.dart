import 'package:flutter/material.dart';
import 'package:qr_code_generator/model/image_save.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_generator/model/qr_code_data.dart';
import 'package:animations/animations.dart';

import 'package:qr_code_generator/view/pages/ai_onboarding_page.dart';
import 'package:qr_code_generator/view/pages/settings_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_code_generator/view/widgets/error_correction_and_colors_card/error_correction_inputs.dart';
import 'package:qr_code_generator/view/widgets/message_input/message_input_card.dart';
import 'package:qr_code_generator/model/qr_code_data.dart';

const double fabDimension = 56.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadPersistentVariables();
  }

  // load the settings the user sets in the settings page
  Future<void> loadPersistentVariables() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedQrCodeSize =
          prefs.getString(qrCodePrefName) ?? qrCodeSizeOptions[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          // Settings FAB
          CustomOpenContainer(
            color: Theme.of(context).colorScheme.onInverseSurface,
            page: SettingsPage(),
            icon: const Icon(Icons.settings),
          ),
          const Spacer(flex: 10),
          // AI FAB
          ValueListenableBuilder<String>(
            valueListenable: qrCodeImageNotifier,
            builder: (context, qrCodeImage, child) {
              return qrCodeImage.isNotEmpty // show fab if qrCodeImage
                  ? CustomOpenContainer(
                      color: Theme.of(context).colorScheme.onPrimary,
                      page: const AiOnbordingPage(),
                      icon: const Icon(CupertinoIcons.sparkles),
                    )
                  : const SizedBox(width: fabDimension, height: fabDimension);
            },
          ),
          const Spacer(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus when tapping outside
        },
        child: const Center(
          child: Column(
            children: [
              Spacer(),

              // Input Fields for the QRcode Message
              MessageInputCard(),

              ErrorCorrectionsAndColorCard(),
              // Display QR Code and buttons card
              DisplayAndActionsCard(),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOpenContainer extends StatelessWidget {
  final Widget page;
  final Icon icon;
  final Color color;

  const CustomOpenContainer({
    super.key,
    required this.color,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 6.0,
      openElevation: 0.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(fabDimension / 8)),
      ),
      openShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(fabDimension / 8)),
      ),
      closedColor: Colors.transparent,
      openColor: Theme.of(context).colorScheme.surface,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: fabDimension,
          width: fabDimension,
          child: FloatingActionButton.small(
            onPressed: openContainer,
            backgroundColor: color,
            child: icon,
          ),
        );
      },
      openBuilder: (BuildContext context, VoidCallback _) {
        return page;
      },
    );
  }
}

class DisplayAndActionsCard extends StatelessWidget {
  const DisplayAndActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      elevation: 1,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: 340, maxHeight: 350, minWidth: 340),
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<String>(
                valueListenable: qrCodeImageNotifier,
                builder: (context, qrCodeImage, child) {
                  return qrCodeImage.isNotEmpty
                      ? Container(
                          height: 250,
                          constraints: const BoxConstraints(
                              maxWidth: 300, maxHeight: 250),
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Image.network(
                            qrCodeImage, // Display the QR code
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),

              // QR Code Buttons: create, recreate, save
              const RowOfQRActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class RowOfQRActionButtons extends StatefulWidget {
  const RowOfQRActionButtons({super.key});

  @override
  RowOfQRActionButtonsState createState() => RowOfQRActionButtonsState();
}

class RowOfQRActionButtonsState extends State<RowOfQRActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Create/Recreate Button
        ValueListenableBuilder<String>(
          valueListenable: qrCodeImageNotifier,
          builder: (context, qrCodeImage, child) {
            return FilledButton(
              onPressed: () => fetchQRCode(context), // Fetch QR code data
              child: Text(qrCodeImage.isNotEmpty
                  ? 'Recreate QR Code'
                  : 'Create QR Code'),
            );
          },
        ),
        const SizedBox(width: 10),
        // Save Button
        ValueListenableBuilder<String>(
          valueListenable: qrCodeImageNotifier,
          builder: (context, qrCodeImage, child) {
            return qrCodeImage.isNotEmpty
                ? IconButton.filledTonal(
                    onPressed: () => saveImage(context, response),
                    icon: const Icon(Icons.save),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
