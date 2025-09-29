import 'dart:async';

import 'package:flutter/material.dart';

class AppMessengerWrapper extends StatefulWidget {
  const AppMessengerWrapper({
    super.key,
    required this.stream,
    required this.child,
  });

  final Stream<String> stream;
  final Widget child;

  @override
  State<AppMessengerWrapper> createState() => _AppMessengerWrapperState();
}

class _AppMessengerWrapperState extends State<AppMessengerWrapper> {
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _subscription = widget.stream.listen(_showSnackBar);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
