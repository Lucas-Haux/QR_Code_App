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

  static MaterialColor createMaterialColor(Color color) {
    Map<int, Color> colorShades = {
      50: Color.fromRGBO(color.red, color.green, color.blue, .1),
      100: Color.fromRGBO(color.red, color.green, color.blue, .2),
      200: Color.fromRGBO(color.red, color.green, color.blue, .3),
      300: Color.fromRGBO(color.red, color.green, color.blue, .4),
      400: Color.fromRGBO(color.red, color.green, color.blue, .5),
      500: Color.fromRGBO(color.red, color.green, color.blue, .6),
      600: Color.fromRGBO(color.red, color.green, color.blue, .7),
      700: Color.fromRGBO(color.red, color.green, color.blue, .8),
      800: Color.fromRGBO(color.red, color.green, color.blue, .9),
      900: color,
    };
    return MaterialColor(color.value, colorShades);
  }

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
      primarySwatch: createMaterialColor(const Color(0xFF99CBFF)),
      accentColor: createMaterialColor(const Color(0xFFB9C6EA)),
      cardColor: createMaterialColor(const Color(0xFF151C24)),
      backgroundColor: createMaterialColor(const Color(0xFF0D1B37)),
      brightness: Brightness.light

      // cardColor: and more
      );

  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: Color(0xFF99CBFF),
      brightness: Brightness.dark,
      contrastLevel: 0);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        theme: ThemeData(
          colorScheme: lightColorScheme ??
              ColorScheme.fromSeed(
                  seedColor: Color(0xFF99CBFF),
                  brightness: Brightness.light,
                  contrastLevel: 0),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ??
              ColorScheme.fromSeed(
                  seedColor: Color(0xFF99CBFF),
                  brightness: Brightness.dark,
                  contrastLevel: 0),
          useMaterial3: true,
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
      elevation: 0,
      duration: contentType == ContentType.success
          ? const Duration(seconds: 3)
          : const Duration(seconds: 12),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
