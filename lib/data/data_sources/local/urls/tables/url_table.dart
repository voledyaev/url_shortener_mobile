import 'package:drift/drift.dart';

class UrlsTable extends Table {
  TextColumn get shortUrl => text()();
  DateTimeColumn get expiresAt => dateTime().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {shortUrl};
}
