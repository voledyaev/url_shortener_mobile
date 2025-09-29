import 'package:flutter/material.dart';
import 'package:url_shortener/gen/assets.gen.dart';
import 'package:url_shortener/ui/theme/theme.dart';

class SplashApp extends StatelessWidget {
  const SplashApp({
    super.key,
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Shortener',
      theme: theme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Assets.images.compass.image(width: 100, height: 100),
              const Text('URL Shortener'),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
