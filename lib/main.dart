import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:qr_code_generator/view/pages/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        theme: ThemeData(
          colorScheme: lightColorScheme ??
              ColorScheme.fromSeed(
                  seedColor: const Color(0xFF99CBFF),
                  brightness: Brightness.light,
                  contrastLevel: 0),
          useMaterial3: true,
          cardTheme: CardTheme(
            color: lightColorScheme?.onSecondaryFixedVariant,
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ??
              ColorScheme.fromSeed(
                  seedColor: const Color(0xFF99CBFF),
                  brightness: Brightness.dark,
                  contrastLevel: 0),
          useMaterial3: true,
          cardTheme: CardTheme(
            color: darkColorScheme?.onSecondaryFixedVariant,
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        scaffoldMessengerKey: SnackBarManager.scaffoldMessengerKey,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

// Error messages
class SnackBarManager {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(
      String title, String message, ContentType contentType) {
    final snackBar = SnackBar(
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
      backgroundColor: Colors.transparent,
      elevation: 6,
      duration: contentType == ContentType.success
          ? const Duration(seconds: 3)
          : const Duration(seconds: 12),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
