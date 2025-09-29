import 'package:flutter/foundation.dart';

@immutable
class UrlModel {
  const UrlModel({
    required this.shortUrl,
    required this.expiresAt,
  });

  final Uri shortUrl;
  final DateTime? expiresAt;
}
