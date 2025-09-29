import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_shortener/di.dart';
import 'package:url_shortener/ui/app/app.dart';
import 'package:url_shortener/ui/splash_app/splash_app.dart';

Future<void> main() async {
  try {
    runApp(const SplashApp());
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    configureDependencies();
    runApp(const App());
  } catch (err) {
    runApp(SplashApp(text: err.toString()));
  }
}
