import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:url_shortener/ui/common/view_model.dart';
import 'package:url_shortener/ui/messenger/messenger.dart';
import 'package:url_shortener/ui/router/router.dart';

@injectable
class AppViewModel extends ViewModel {
  AppViewModel(
    this._router,
    this._messenger,
  );

  final AppRouter _router;
  final AppMessenger _messenger;

  RouterConfig<Object>? get routerConfig => _router.config();

  Stream<String> get messages => _messenger.stream;
}
