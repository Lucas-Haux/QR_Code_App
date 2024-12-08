import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animations/animations.dart';

import 'package:qr_code_generator/view/pages/ai_onboarding_page.dart';
import 'package:qr_code_generator/view/pages/settings_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_code_generator/view/components/error_correction_and_colors_card.dart';
import 'package:qr_code_generator/view/widgets/image_display_widget.dart';
import 'package:qr_code_generator/view/widgets/create_and_save_widget.dart';

import 'package:qr_code_generator/view/components/message_input_card.dart';
import 'package:qr_code_generator/viewModel/homepage_viewmodel.dart';

import 'package:qr_code_generator/view/widgets/slider_widget.dart';

const double fabDimension = 56.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override

  // gets presistent settings, should be a repositroy holding variables
  // maybe?
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus when tapping outside
        },
        child: Center(
          child: Column(
            children: [
              const Spacer(),

              // Input Fields for the QRcode Message
              MessageInputCard(
                setWifiType: QrHomepageViewmodel().setWifiType,
                wifiTypeNotifier: wifiTypeNotifier,
                setLinkType: QrHomepageViewmodel().setLinkType,
                linkTypeNotifier: linkTypeNotifier,
                firstController: firstTextController,
                secondController: secondTextController,
                thirdController: thirdTextController,
                messageTypeNotifier: messageTypeNotifier,
                setMessageType: QrHomepageViewmodel().setMessageType,
              ),

              // Error Correction And Colors Selections Card
              ErrorCorrectionAndColorsCard(
                setErrorCorrection: QrHomepageViewmodel().setErrorCorrection,
                errorCorrectionLevelNotifier: errorCorrectionLevelNotifier,
                foregroundColorNotifier: foregroundColorNotifier,
                backgroundColorNotifier: backgroundColorNotifier,
                colorUpdate: QrHomepageViewmodel().setColor,
              ),
              // Display QR Code and buttons
              _QrcodeImageDisplayAndButtonsCard(
                saveImageFunction: QrHomepageViewmodel().saveImage,
                updateQrcodeFunction: QrHomepageViewmodel().updateUrl,
                qrcodeImageUrlNotifier: qrcodeImageUrlNotifier,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
      //FABs
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          // Settings FAB
          _CustomFAB(
            color: Theme.of(context).colorScheme.onInverseSurface,
            page: SettingsPage(),
            icon: const Icon(Icons.settings),
          ),
          const Spacer(flex: 10),
          // AI FAB
          ValueListenableBuilder<String>(
            valueListenable: qrcodeImageUrlNotifier,
            builder: (context, qrCodeImage, child) {
              return qrCodeImage.isNotEmpty // show fab if qrCodeImage
                  ? _CustomFAB(
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
    );
  }
}

class _QrcodeImageDisplayAndButtonsCard extends StatelessWidget {
  final ValueNotifier<String> qrcodeImageUrlNotifier;
  final VoidCallback saveImageFunction;
  final VoidCallback updateQrcodeFunction;
  const _QrcodeImageDisplayAndButtonsCard({
    required this.saveImageFunction,
    required this.updateQrcodeFunction,
    required this.qrcodeImageUrlNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: 340, minWidth: 340, maxHeight: 350),
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageDisplay(
                qrcodeImageUrlNotifier: qrcodeImageUrlNotifier,
                loadingNotifier: qrcodeLoadingNotifier,
              ),
              CreateAndSaveButtons(
                qrcodeImageUrlNotifier: qrcodeImageUrlNotifier,
                saveImageFunction: saveImageFunction,
                updateQrcodeFunction: updateQrcodeFunction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// settings/ai FABs
class _CustomFAB extends StatelessWidget {
  final Widget page;
  final Icon icon;
  final Color color;

  const _CustomFAB({
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
