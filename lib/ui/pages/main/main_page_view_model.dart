import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_shortener/data/repositories/urls/models/url_model.dart';
import 'package:url_shortener/data/repositories/urls/urls_repository.dart';
import 'package:url_shortener/ui/common/view_model.dart';
import 'package:url_shortener/ui/router/router.dart';
import 'package:url_shortener/ui/router/router.gr.dart';

@injectable
class MainPageViewModel extends ViewModel {
  MainPageViewModel(
    this._repository,
    this._router,
  );

  final UrlsRepository _repository;
  final AppRouter _router;

  late final ValueNotifier<List<UrlModel>?> _state;
  late final StreamSubscription<List<UrlModel>?> _subscription;

  ValueListenable<List<UrlModel>?> get state => _state;

  void onUrlTap(UrlModel url) {
    final expiresAt = url.expiresAt;
    final now = DateTime.now();

    final expired = expiresAt != null && !expiresAt.isAfter(now);
    if (expired) return;

    _router.push(StatsRoute(url: url));
  }

  Future<void> onAddPressed() async {
    final result = await _router.push<(Uri, int?)>(const ShortenUrlRoute());
    if (result == null) return;

    final (url, ttl) = result;
    _repository.shortenUrl(url, ttl);
  }

  @postConstruct
  @override
  void init() {
    final initial = _repository.urlsStream.value;
    _state = ValueNotifier(initial);
    _subscription = _repository.urlsStream.listen((e) {
      _state.value = e;
    });
  }

  @override
  void dispose() {
    _state.dispose();
    _subscription.cancel();
  }
}
