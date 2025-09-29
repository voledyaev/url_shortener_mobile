import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_shortener/data/data_sources/local/common/db.dart';
import 'package:url_shortener/data/data_sources/local/urls/urls_local_data_source.dart';
import 'package:url_shortener/data/data_sources/remote/urls/dtos/shorten_request_dto.dart';
import 'package:url_shortener/data/data_sources/remote/urls/urls_remote_data_source.dart';
import 'package:url_shortener/data/repositories/urls/models/stats_model.dart';
import 'package:url_shortener/data/repositories/urls/models/url_model.dart';

@singleton
class UrlsRepository {
  UrlsRepository(
    this._localDataSource,
    this._remoteDataSource,
  );

  final UrlsLocalDataSource _localDataSource;
  final UrlsRemoteDataSource _remoteDataSource;

  ValueStream<List<UrlModel>?> get urlsStream => _localDataSource.urlsStream
      .map(
        (e) => e
            .map(
              (e) => UrlModel(
                shortUrl: Uri.parse(e.shortUrl),
                expiresAt: e.expiresAt,
              ),
            )
            .toList(),
      )
      .cast<List<UrlModel>?>()
      .publishValueSeeded(null)
      .autoConnect();

  Future<void> shortenUrl(Uri url, int? ttl) async {
    final data = await _remoteDataSource.shortenUrl(
      ShortenRequestDto(
        url: url,
        ttl: ttl,
      ),
    );
    await _localDataSource.saveUrl(
      UrlsTableCompanion.insert(
        shortUrl: data.shortUrl.toString(),
        expiresAt: Value(data.expiresAt),
      ),
    );
  }

  ValueStream<StatsModel?> getStatsStream(String url) => _localDataSource
      .getStatsStream(url)
      .map(
        (e) => e == null
            ? null
            : StatsModel(
                shortUrl: Uri.parse(e.shortUrl),
                original: Uri.parse(e.original),
                createdAt: e.createdAt,
                expiresAt: e.expiresAt,
                clicks: e.clicks,
              ),
      )
      .publishValueSeeded(null)
      .autoConnect();

  Future<void> updateStats(UrlModel url) async {
    final id = url.shortUrl.pathSegments.last;
    final data = await _remoteDataSource.getStats(id);
    await _localDataSource.saveStats(
      StatsTableCompanion.insert(
        shortUrl: url.shortUrl.toString(),
        original: data.original.toString(),
        createdAt: data.createdAt,
        expiresAt: Value(data.expiresAt),
        clicks: data.clicks,
      ),
    );
  }
}
