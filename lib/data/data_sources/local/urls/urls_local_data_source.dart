import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:url_shortener/data/data_sources/local/common/db.dart';

@singleton
class UrlsLocalDataSource {
  UrlsLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<UrlsTableData>> get urlsStream => _db.urlsTable.all().watch();
  Future<void> saveUrl(Insertable<UrlsTableData> url) => _db.urlsTable.insertOnConflictUpdate(url);

  Stream<StatsTableData?> getStatsStream(String url) =>
      (_db.statsTable.select()..where((u) => u.shortUrl.equals(url))).watchSingleOrNull();
  Future<void> saveStats(Insertable<StatsTableData> stats) => _db.statsTable.insertOnConflictUpdate(stats);
}
