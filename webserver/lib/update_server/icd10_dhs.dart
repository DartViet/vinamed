import 'dart:io';
import 'package:webserver/update_server/queries.dart';
import 'package:webserver/update_server/sqlite_controller.dart';
import 'package:webserver/update_server/variables.dart';

class Icd10cm {
  static Icd10cm? _instance;

  Icd10cm._internal();

  static Icd10cm get instance {
    _instance ??= Icd10cm._internal();
    return _instance!;
  }

  void _insertItemToDatabase(Icd10Item item, String tableName) {
    SqliteController.instance.db.execute(Queries.instance.getUpsertValue(tableName), [item.code, item.descriptionEn, item.descriptionVi, item.descriptionZh]);
  }

  Future<void> getItemFromFile(String filePath, String tableName) async {
    final file = File(filePath);
    final lines = await file.readAsLines();

    if (tableName == Variables.instance.dhsTable) {
      for (String line in lines) {
        List<String> parts = line.split('\t');
        if (parts.length >= 2 && parts[0].trim().isNotEmpty && parts[0].trim().length == 5 && parts[1].trim().isNotEmpty) {
          final item = Icd10Item(parts[0].trim(), parts[1].trim());
          if (item.descriptionEn.startsWith('"') && item.descriptionEn.endsWith('"')) {
            item.descriptionEn = item.descriptionEn.substring(1, item.descriptionEn.length - 1);
          }
          _insertItemToDatabase(item, tableName);
        }
      }
    } else {
      for (String line in lines) {
        if (line.trim().isNotEmpty && line.length >= 9) {
          final item = Icd10Item.fromText(line);
          _insertItemToDatabase(item, tableName);
        }
      }
    }
  }
}

class Icd10Item {
  String code = '';
  String descriptionEn = '';
  String descriptionVi = '';
  String descriptionZh = '';

  Icd10Item(this.code, this.descriptionEn, [this.descriptionVi = '', this.descriptionZh = '']);

  Icd10Item.fromText(String text) {
    code = text.substring(0, 8).trim();
    String description = text.substring(8).trim();

    // Remove quotes if they exist
    if (description.startsWith('"') && description.endsWith('"')) {
      description = description.substring(1, description.length - 1);
    }

    descriptionEn = description;
  }
}
