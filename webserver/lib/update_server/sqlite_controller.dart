import 'package:sqlite3/sqlite3.dart';
import 'package:webserver/update_server/queries.dart';
import 'package:webserver/update_server/variables.dart';

class SqliteController {
  // Singleton instance
  static final SqliteController _instance = SqliteController._internal();

  // Private constructor
  SqliteController._internal() {
    // Enable WAL mode
    db.execute('PRAGMA journal_mode = WAL;');
    db.execute(Queries.instance.getCreateIcd10(Variables.instance.icd10cmTable));
    db.execute(Queries.instance.getCreateIcd10(Variables.instance.icd10pcsTable));
    db.execute(Queries.instance.getCreateIcd10(Variables.instance.dhsTable));
    db.execute(Queries.instance.createLoincTable(Variables.instance.lonicTable));
    db.execute(Queries.instance.createFdaDrugTable(Variables.instance.fdaDrugTable));
  }

  static SqliteController get instance {
    return _instance;
  }

  // Database connection - creates file if it doesn't exist
  final db = sqlite3.open('assets/data.db');
}
