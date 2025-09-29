import 'package:flutter/foundation.dart';

@immutable
class StatsModel {
  const StatsModel({
    required this.shortUrl,
    required this.original,
    required this.createdAt,
    required this.expiresAt,
    required this.clicks,
  });

  final Uri shortUrl;
  final Uri original;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final int clicks;
}
