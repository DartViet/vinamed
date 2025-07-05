import 'dart:io';

import 'package:webserver/update_server/queries.dart';
import 'package:webserver/update_server/sqlite_controller.dart';

class FdaDrug {
  static FdaDrug? _instance;

  FdaDrug._internal();

  static FdaDrug get instance {
    _instance ??= FdaDrug._internal();
    return _instance!;
  }

  void _insertItemToDatabase(FdaDrugItem item, String tableName) {
    SqliteController.instance.db.execute(Queries.instance.getFdaDrugUpsertValue(tableName), [
      item.applNo,
      item.productNo,
      item.form,
      item.strength,
      item.referenceDrug,
      item.drugName,
      item.activeIngredient,
      item.referenceStandard,
    ]);
  }

  Future<void> getItemFromFile(String filePath, String tableName) async {
    final file = File(filePath);
    final lines = await file.readAsLines();

    // Skip header line if present
    bool skipFirst = true;

    for (String line in lines) {
      if (skipFirst) {
        skipFirst = false;
        continue;
      }

      if (line.trim().isNotEmpty) {
        final item = FdaDrugItem.fromTabDelimitedLine(line);
        if (item.applNo.isNotEmpty) {
          _insertItemToDatabase(item, tableName);
        }
      }
    }
  }
}

class FdaDrugItem {
  String applNo = '';
  String productNo = '';
  String form = '';
  String strength = '';
  String referenceDrug = '';
  String drugName = '';
  String activeIngredient = '';
  String referenceStandard = '';

  FdaDrugItem();

  FdaDrugItem.fromTabDelimitedLine(String line) {
    // Parse tab-delimited line
    List<String> fields = line.split('\t');

    if (fields.length >= 8) {
      applNo = fields[0].trim();
      productNo = fields[1].trim();
      form = fields[2].trim();
      strength = fields[3].trim();
      referenceDrug = fields[4].trim();
      drugName = fields[5].trim();
      activeIngredient = fields[6].trim();
      referenceStandard = fields[7].trim();

      // Remove quotes if they exist for any field
      applNo = _removeQuotes(applNo);
      productNo = _removeQuotes(productNo);
      form = _removeQuotes(form);
      strength = _removeQuotes(strength);
      referenceDrug = _removeQuotes(referenceDrug);
      drugName = _removeQuotes(drugName);
      activeIngredient = _removeQuotes(activeIngredient);
      referenceStandard = _removeQuotes(referenceStandard);
    }
  }

  String _removeQuotes(String text) {
    if (text.startsWith('"') && text.endsWith('"')) {
      return text.substring(1, text.length - 1);
    }
    return text;
  }
}
