import 'dart:convert';

import 'package:database_models/models/codes_data_models/fda_drug_model.dart';
import 'package:shelf/shelf.dart';
import 'package:database_models/models/common/translated.dart';
import 'package:webserver/translation/translation.dart';
import 'package:webserver/update_server/sqlite_controller.dart';
import 'package:webserver/update_server/variables.dart';

class FdaDrugController {
  static final instance = FdaDrugController._();

  FdaDrugController._() {
    updateQuery =
        '''UPDATE ${Variables.instance.fdaDrugTable} SET 
      ${_createUpdateSubQuery()}
      WHERE ${FdaDrugModel.applNoStr} = ?;
    ''';

    searchQuery =
        '''
      SELECT * FROM ${Variables.instance.fdaDrugTable} WHERE
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

    List<FdaDrugModel> items = SqliteController.instance.db.select(searchQuery, _getListSearchString(searchStr)).map((row) {
      var item = FdaDrugModel.fromMap(row);
      return item;
    }).toList();

    // Do not await here, as we want to update items in the background
    updateItems(items);

    return Response.ok(json.encode(items.map((item) => item.toJson()).toList()), headers: {'Content-Type': 'application/json'});
  }

  // Regex pattern to check for at least 3 alphabetic characters
  RegExp atLeast3Chars = RegExp(r'[a-zA-Z].*[a-zA-Z].*[a-zA-Z]');

  Future<void> updateItems(List<FdaDrugModel> items) async {
    for (var item in items) {
      bool needsUpdate = false;

      // Check and translate productNo
      Translated productNoTran = await translateString(item.productNo, item.productNoVi, item.productNoZh);
      if (productNoTran.translated) {
        item.productNoVi = productNoTran.translatedVi;
        item.productNoZh = productNoTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate form
      Translated formTran = await translateString(item.form, item.formVi, item.formZh);
      if (formTran.translated) {
        item.formVi = formTran.translatedVi;
        item.formZh = formTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate strength
      Translated strengthTran = await translateString(item.strength, item.strengthVi, item.strengthZh);
      if (strengthTran.translated) {
        item.strengthVi = strengthTran.translatedVi;
        item.strengthZh = strengthTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate referenceDrug
      Translated referenceDrugTran = await translateString(item.referenceDrug, item.referenceDrugVi, item.referenceDrugZh);
      if (referenceDrugTran.translated) {
        item.referenceDrugVi = referenceDrugTran.translatedVi;
        item.referenceDrugZh = referenceDrugTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate drugName
      Translated drugNameTran = await translateString(item.drugName, item.drugNameVi, item.drugNameZh);
      if (drugNameTran.translated) {
        item.drugNameVi = drugNameTran.translatedVi;
        item.drugNameZh = drugNameTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate activeIngredient
      Translated activeIngredientTran = await translateString(item.activeIngredient, item.activeIngredientVi, item.activeIngredientZh);
      if (activeIngredientTran.translated) {
        item.activeIngredientVi = activeIngredientTran.translatedVi;
        item.activeIngredientZh = activeIngredientTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate referenceStandard
      Translated referenceStandardTran = await translateString(item.referenceStandard, item.referenceStandardVi, item.referenceStandardZh);
      if (referenceStandardTran.translated) {
        item.referenceStandardVi = referenceStandardTran.translatedVi;
        item.referenceStandardZh = referenceStandardTran.translatedZh;
        needsUpdate = true;
      }

      if (needsUpdate) {
        print("Updating item: ${item.applNo}");
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

  bool _updateItem(FdaDrugModel item) {
    if (item.applNo.isEmpty) {
      return false; // Cannot update item without an application number
    }
    try {
      SqliteController.instance.db.execute(updateQuery, item.getValueList());
      return true;
    } catch (e) {
      print('Error updating item: $e');
      return false; // Item not found or update failed
    }
  }

  Response getFdaDrugItems(Request request, String applNo) {
    final item = SqliteController.instance.db.select(selectItemQuery, [applNo.trim()]);
    if (item.isEmpty) {
      return Response.notFound('FDA Drug item not found');
    }
    final fdaDrugItem = FdaDrugModel.fromMap(item.first);
    return Response.ok(fdaDrugItem.toJson(), headers: {'Content-Type': 'application/json'});
  }

  String searchQuery = '';

  String updateQuery = '';

  String selectItemQuery = '''SELECT * FROM ${Variables.instance.fdaDrugTable} WHERE ${FdaDrugModel.applNoStr} = ?''';

  String _createUpdateSubQuery() {
    StringBuffer subQuery = StringBuffer();
    for (String columnName in FdaDrugModel.fdaDrugFieldConstants) {
      if (columnName == FdaDrugModel.applNoStr) continue; // Skip applNo as it is used in WHERE clause
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
    for (String columnName in FdaDrugModel.fdaDrugFieldConstants) {
      subQuery.write('$columnName LIKE ? OR ');
    }
    String subQueryStr = subQuery.toString();
    if (subQueryStr.isNotEmpty) {
      subQueryStr = subQueryStr.substring(0, subQueryStr.length - 4);
    }
    return subQueryStr;
  }

  List<String> _getListSearchString(String searchStr) {
    var listSearchString = List.generate(FdaDrugModel.fdaDrugFieldConstants.length, (index) => '%$searchStr%');
    return listSearchString;
  }
}
