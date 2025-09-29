import 'dart:async';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/data/repositories/urls/models/url_model.dart';
import 'package:url_shortener/ui/pages/main/main_page_view_model.dart';

class MainTile extends StatefulWidget {
  const MainTile({
    super.key,
    required this.url,
  });

  final UrlModel url;

  @override
  State<MainTile> createState() => _MainTileState();
}

class _MainTileState extends State<MainTile> {
  Timer? _timer;
  late final ValueNotifier<String> _state;

  @override
  void initState() {
    super.initState();
    _mapExpiresAt();
  }

  void _mapExpiresAt() {
    final expiresAt = widget.url.expiresAt;
    if (expiresAt == null) {
      _state = ValueNotifier('Unlimited');
      return;
    }

    final now = DateTime.now();
    if (!expiresAt.isAfter(now)) {
      _state = ValueNotifier('Expired');
      return;
    }

    _state = ValueNotifier(_format(now, expiresAt));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (!expiresAt.isAfter(now)) {
        _state.value = 'Expired';
        return;
      }

      _state.value = _format(now, expiresAt);
    });
  }

  String _format(DateTime now, DateTime expiresAt) => expiresAt.difference(now).pretty();

  @override
  void dispose() {
    _timer?.cancel();
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainPageViewModel>();
    final title = widget.url.shortUrl.toString();

    return ListTile(
      onTap: () => viewModel.onUrlTap(widget.url),
      title: Text(title),
      subtitle: ValueListenableBuilder(
        valueListenable: _state,
        builder: (context, value, child) => Text(value),
      ),
    );
  }
}
