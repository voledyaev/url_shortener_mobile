import 'package:drift/drift.dart';

class StatsTable extends Table {
  TextColumn get shortUrl => text()();
  TextColumn get original => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  IntColumn get clicks => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {shortUrl};
}
