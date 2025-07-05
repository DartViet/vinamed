import 'dart:convert';

import 'package:database_models/models/codes_data_models/icd10cm_model.dart';
import 'package:database_models/models/common/translated.dart';
import 'package:shelf/shelf.dart';
import 'package:webserver/translation/translation.dart';
import 'package:webserver/update_server/sqlite_controller.dart';
import 'package:webserver/update_server/variables.dart';

class Icd10cmController {
  static final instance = Icd10cmController._();

  Icd10cmController._() {
    updateQuery =
        '''UPDATE ${Variables.instance.icd10cmTable} SET 
      ${_createUpdateSubQuery()}
      WHERE ${Icd10CmItemModel.codeStr} = ?;
    ''';

    searchQuery =
        '''
      SELECT * FROM ${Variables.instance.icd10cmTable} WHERE
      ${_searchSubQuery()} LIMIT 15;''';
  }

  Future<Response> searchItem(Request request) async {
    String searchStr = '';
    try {
      final body = await request.readAsString();
      searchStr = body.isNotEmpty ? body.trim() : '';
    } catch (e) {
      print('Error in searchItem: $e');
      return Response.internalServerError(body: 'Error searching items');
    }

    if (searchStr.isEmpty) {
      return Response.ok('[]', headers: {'Content-Type': 'application/json'});
    }

    List<Icd10CmItemModel> items = SqliteController.instance.db.select(searchQuery, _getListSearchString(searchStr)).map((row) {
      var item = Icd10CmItemModel.fromMap(row);
      return item;
    }).toList();

    // Do not await here, as we want to update items in the background
    updateItems(items);

    return Response.ok(json.encode(items.map((item) => item.toJson()).toList()), headers: {'Content-Type': 'application/json'});
  }

  // Regex pattern to check for at least 3 alphabetic characters
  RegExp atLeast3Chars = RegExp(r'[a-zA-Z].*[a-zA-Z].*[a-zA-Z]');

  Future<void> updateItems(List<Icd10CmItemModel> items) async {
    for (var item in items) {
      bool needsUpdate = false;

      // Check and translate descriptionEn
      Translated descriptionEnTran = await translateString(item.descriptionEn, item.descriptionVi, item.descriptionZh);
      if (descriptionEnTran.translated) {
        item.descriptionVi = descriptionEnTran.translatedVi;
        item.descriptionZh = descriptionEnTran.translatedZh;
        needsUpdate = true;
      }

      if (needsUpdate) {
        print("Updating item: ${item.code}");
      }

      // Update the database if translations were added
      if (needsUpdate) {
        _updateItem(item);
      }
    }
  }

  Future<Translated> translateString(String original, String translatedVi, String translatedZh) async {
    bool translated = false;
    if (translatedVi.isEmpty && atLeast3Chars.hasMatch(original)) {
      try {
        translatedVi = await Translation.instance.translateStringWithHttp(original.trim(), 'vi');
        translated = true;
      } catch (e) {
        print('Error translating to Vietnamese: $e');
      }
    } else if (translatedVi.isEmpty && original.isNotEmpty) {
      translatedVi = original; // Fallback to original if translation fails
      translated = true;
    }
    if (translatedZh.isEmpty && atLeast3Chars.hasMatch(original)) {
      try {
        translatedZh = await Translation.instance.translateStringWithHttp(original.trim(), 'zh');
        translated = true;
      } catch (e) {
        print('Error translating to Chinese: $e');
      }
    } else if (translatedZh.isEmpty && original.isNotEmpty) {
      translatedZh = original; // Fallback to original if translation fails
      translated = true;
    }
    return Translated(translatedVi: translatedVi, translatedZh: translatedZh, translated: translated);
  }

  bool _updateItem(Icd10CmItemModel item) {
    if (item.code.isEmpty) {
      return false; // Cannot update item without a code
    }
    try {
      SqliteController.instance.db.execute(updateQuery, item.getValueList());
      return true;
    } catch (e) {
      print('Error updating item: $e');
      return false; // Item not found or update failed
    }
  }

  Response getIcd10CmItem(Request request, String code) {
    final item = SqliteController.instance.db.select(selectItemQuery, [code.trim()]);
    if (item.isEmpty) {
      return Response.notFound('ICD10CM item not found');
    }
    final icd10cmItem = Icd10CmItemModel.fromMap(item.first);
    return Response.ok(icd10cmItem.toJson(), headers: {'Content-Type': 'application/json'});
  }

  String searchQuery = '';

  String updateQuery = '';

  String selectItemQuery = '''SELECT * FROM ${Variables.instance.icd10cmTable} WHERE ${Icd10CmItemModel.codeStr} = ?''';

  String _createUpdateSubQuery() {
    StringBuffer subQuery = StringBuffer();
    for (String columnName in Icd10CmItemModel.icd10cmFieldConstants) {
      if (columnName == Icd10CmItemModel.codeStr) continue; // Skip code as it is used in WHERE clause
      subQuery.write('$columnName = ?, ');
    }
    String subQueryStr = subQuery.toString();
    if (subQueryStr.isNotEmpty) {
      subQueryStr = subQueryStr.substring(0, subQueryStr.length - 2);
    }
    return subQueryStr;
  }

  String _searchSubQuery() {
    StringBuffer subQuery = StringBuffer();
    for (String columnName in Icd10CmItemModel.icd10cmFieldConstants) {
      subQuery.write('$columnName LIKE ? OR ');
    }
    String subQueryStr = subQuery.toString();
    if (subQueryStr.isNotEmpty) {
      subQueryStr = subQueryStr.substring(0, subQueryStr.length - 4);
    }
    return subQueryStr;
  }

  List<String> _getListSearchString(String searchStr) {
    var listSearchString = List.generate(Icd10CmItemModel.icd10cmFieldConstants.length, (index) => '%$searchStr%');
    return listSearchString;
  }
}
