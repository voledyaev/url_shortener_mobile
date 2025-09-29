import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_shortener/data/repositories/urls/models/stats_model.dart';
import 'package:url_shortener/data/repositories/urls/models/url_model.dart';
import 'package:url_shortener/data/repositories/urls/urls_repository.dart';
import 'package:url_shortener/ui/common/view_model.dart';
import 'package:url_shortener/ui/messenger/messenger.dart';
import 'package:url_shortener/ui/router/router.dart';

@injectable
class StatsPageViewModel extends ViewModel {
  StatsPageViewModel(
    this._repository,
    this._router,
    this._messenger,
    @factoryParam UrlModel? url,
  ) : _url = url!;

  final UrlsRepository _repository;
  final AppRouter _router;
  final AppMessenger _messenger;
  final UrlModel _url;

  late final ValueNotifier<StatsModel?> _state;
  late final StreamSubscription<StatsModel?> _subscription;

  ValueListenable<StatsModel?> get state => _state;

  void onBackPressed() => _router.pop();

  void onUrlTap() {
    _messenger.show('Copied!');
    Clipboard.setData(ClipboardData(text: _url.shortUrl.toString()));
  }

  Future<void> onOpenPressed() async {
    final url = _url.shortUrl;
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @postConstruct
  @override
  void init() {
    final urlString = _url.shortUrl.toString();

    final initial = _repository.getStatsStream(urlString).value;
    _state = ValueNotifier(initial);
    _subscription = _repository.getStatsStream(urlString).listen((e) {
      _state.value = e;
    });

    _repository.updateStats(_url);
  }

  @override
  void dispose() {
    _state.dispose();
    _subscription.cancel();
  }
}
