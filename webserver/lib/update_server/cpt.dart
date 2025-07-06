import 'dart:io';

import 'package:webserver/update_server/queries.dart';
import 'package:webserver/update_server/sqlite_controller.dart';

class Cpt {
  static Cpt? _instance;

  Cpt._internal();

  static Cpt get instance {
    _instance ??= Cpt._internal();
    return _instance!;
  }

  Future<void> getItemFromFile(String folderPath, String tableName) async {
    final directory = Directory(folderPath);
    final files = directory.listSync();

    for (var file in files) {
      if (file is File) {
        final lines = await file.readAsLines();

        // Skip the first line (header) for CSV files
        for (int i = 1; i < lines.length; i++) {
          final line = lines[i];
          if (line.trim().isNotEmpty) {
            final item = CptItem.fromText(line);
            _insertItemToDatabase(item, tableName);
          }
        }
      }
    }
  }

  void _insertItemToDatabase(CptItem item, String tableName) {
    SqliteController.instance.db.execute(Queries.instance.getUpsertValue(tableName), [item.code, item.descriptionEn, item.descriptionVi, item.descriptionZh]);
  }
}

class CptItem {
  String code = '';
  String descriptionEn = '';
  String descriptionVi = '';
  String descriptionZh = '';

  CptItem(this.code, this.descriptionEn, [this.descriptionVi = '', this.descriptionZh = '']);

  CptItem.fromText(String text) {
    List<String> parts = text.split(',');
    code = parts[0].trim();
    descriptionEn = parts[1].trim();
    descriptionVi = '';
    descriptionZh = '';
  }
}
