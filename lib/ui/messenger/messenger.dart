import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppMessenger {
  final _subject = PublishSubject<String>();

  Stream<String> get stream => _subject.stream;

  void show(String message) {
    _subject.add(message);
  }

  @disposeMethod
  void dispose() {
    _subject.close();
  }
}
