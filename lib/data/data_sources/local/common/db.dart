import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_shortener/data/data_sources/local/urls/tables/stats_table.dart';
import 'package:url_shortener/data/data_sources/local/urls/tables/url_table.dart';

part 'db.g.dart';

@Singleton(dispose: dispose)
@DriftDatabase(tables: [UrlsTable, StatsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

void dispose(AppDatabase instance) {
  instance.close();
}
