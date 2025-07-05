import 'dart:convert';

import 'package:database_models/models/codes_data_models/loinc_model.dart';
import 'package:database_models/models/common/translated.dart';
import 'package:shelf/shelf.dart';
import 'package:webserver/translation/translation.dart';
import 'package:webserver/update_server/sqlite_controller.dart';
import 'package:webserver/update_server/variables.dart';

class LoincController {
  static final instance = LoincController._();

  LoincController._() {
    updateQuery =
        '''UPDATE ${Variables.instance.lonicTable} SET 
      ${_createUpdateSubQuery()}
      WHERE ${LoincItemModel.loincNumStr} = ?;
    ''';

    searchQuery =
        '''
      SELECT * FROM ${Variables.instance.lonicTable} WHERE
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

    List<LoincItemModel> items = SqliteController.instance.db.select(searchQuery, _getListSearchString(searchStr)).map((row) {
      var item = LoincItemModel.fromMap(row);
      return item;
    }).toList();

    // Do not await here, as we want to update items in the background
    updateItems(items);

    return Response.ok(json.encode(items.map((item) => item.toJson()).toList()), headers: {'Content-Type': 'application/json'});
  }

  // Regex pattern to check for at least 3 alphabetic characters
  RegExp atLeast3Chars = RegExp(r'[a-zA-Z].*[a-zA-Z].*[a-zA-Z]');

  Future<void> updateItems(List<LoincItemModel> items) async {
    for (var item in items) {
      bool needsUpdate = false;

      // Check and translate component
      Translated componentTran = await translateString(item.component, item.componentVi, item.componentZh);
      if (componentTran.translated) {
        item.componentVi = componentTran.translatedVi;
        item.componentZh = componentTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate property
      Translated propertyTran = await translateString(item.property, item.propertyVi, item.propertyZh);
      if (propertyTran.translated) {
        item.propertyVi = propertyTran.translatedVi;
        item.propertyZh = propertyTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate timeAspct
      Translated timeAspctTran = await translateString(item.timeAspct, item.timeAspctVi, item.timeAspctZh);
      if (timeAspctTran.translated) {
        item.timeAspctVi = timeAspctTran.translatedVi;
        item.timeAspctZh = timeAspctTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate system
      Translated systemTran = await translateString(item.system, item.systemVi, item.systemZh);
      if (systemTran.translated) {
        item.systemVi = systemTran.translatedVi;
        item.systemZh = systemTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate scaleTyp
      Translated scaleTypTran = await translateString(item.scaleTyp, item.scaleTypVi, item.scaleTypZh);
      if (scaleTypTran.translated) {
        item.scaleTypVi = scaleTypTran.translatedVi;
        item.scaleTypZh = scaleTypTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate methodTyp
      Translated methodTypTran = await translateString(item.methodTyp, item.methodTypVi, item.methodTypZh);
      if (methodTypTran.translated) {
        item.methodTypVi = methodTypTran.translatedVi;
        item.methodTypZh = methodTypTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate classField
      Translated classTran = await translateString(item.classField, item.classVi, item.classZh);
      if (classTran.translated) {
        item.classVi = classTran.translatedVi;
        item.classZh = classTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate longCommonName
      Translated longCommonNameTran = await translateString(item.longCommonName, item.longCommonNameVi, item.longCommonNameZh);
      if (longCommonNameTran.translated) {
        item.longCommonNameVi = longCommonNameTran.translatedVi;
        item.longCommonNameZh = longCommonNameTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate shortName
      Translated shortNameTran = await translateString(item.shortName, item.shortNameVi, item.shortNameZh);
      if (shortNameTran.translated) {
        item.shortNameVi = shortNameTran.translatedVi;
        item.shortNameZh = shortNameTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate displayName
      Translated displayNameTran = await translateString(item.displayName, item.displayNameVi, item.displayNameZh);
      if (displayNameTran.translated) {
        item.displayNameVi = displayNameTran.translatedVi;
        item.displayNameZh = displayNameTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate definitionDescription
      Translated definitionDescriptionTran = await translateString(item.definitionDescription, item.definitionDescriptionVi, item.definitionDescriptionZh);
      if (definitionDescriptionTran.translated) {
        item.definitionDescriptionVi = definitionDescriptionTran.translatedVi;
        item.definitionDescriptionZh = definitionDescriptionTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate status
      Translated statusTran = await translateString(item.status, item.statusVi, item.statusZh);
      if (statusTran.translated) {
        item.statusVi = statusTran.translatedVi;
        item.statusZh = statusTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate consumerName
      Translated consumerNameTran = await translateString(item.consumerName, item.consumerNameVi, item.consumerNameZh);
      if (consumerNameTran.translated) {
        item.consumerNameVi = consumerNameTran.translatedVi;
        item.consumerNameZh = consumerNameTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate classType
      Translated classTypeTran = await translateString(item.classType, item.classTypeVi, item.classTypeZh);
      if (classTypeTran.translated) {
        item.classTypeVi = classTypeTran.translatedVi;
        item.classTypeZh = classTypeTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate formula
      Translated formulaTran = await translateString(item.formula, item.formulaVi, item.formulaZh);
      if (formulaTran.translated) {
        item.formulaVi = formulaTran.translatedVi;
        item.formulaZh = formulaTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate exmplAnswers
      Translated exmplAnswersTran = await translateString(item.exmplAnswers, item.exmplAnswersVi, item.exmplAnswersZh);
      if (exmplAnswersTran.translated) {
        item.exmplAnswersVi = exmplAnswersTran.translatedVi;
        item.exmplAnswersZh = exmplAnswersTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate surveyQuestText
      Translated surveyQuestTextTran = await translateString(item.surveyQuestText, item.surveyQuestTextVi, item.surveyQuestTextZh);
      if (surveyQuestTextTran.translated) {
        item.surveyQuestTextVi = surveyQuestTextTran.translatedVi;
        item.surveyQuestTextZh = surveyQuestTextTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate surveyQuestSrc
      Translated surveyQuestSrcTran = await translateString(item.surveyQuestSrc, item.surveyQuestSrcVi, item.surveyQuestSrcZh);
      if (surveyQuestSrcTran.translated) {
        item.surveyQuestSrcVi = surveyQuestSrcTran.translatedVi;
        item.surveyQuestSrcZh = surveyQuestSrcTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate unitsRequired
      Translated unitsRequiredTran = await translateString(item.unitsRequired, item.unitsRequiredVi, item.unitsRequiredZh);
      if (unitsRequiredTran.translated) {
        item.unitsRequiredVi = unitsRequiredTran.translatedVi;
        item.unitsRequiredZh = unitsRequiredTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate relatedNames2
      Translated relatedNames2Tran = await translateString(item.relatedNames2, item.relatedNames2Vi, item.relatedNames2Zh);
      if (relatedNames2Tran.translated) {
        item.relatedNames2Vi = relatedNames2Tran.translatedVi;
        item.relatedNames2Zh = relatedNames2Tran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate orderObs
      Translated orderObsTran = await translateString(item.orderObs, item.orderObsVi, item.orderObsZh);
      if (orderObsTran.translated) {
        item.orderObsVi = orderObsTran.translatedVi;
        item.orderObsZh = orderObsTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate hl7FieldSubfieldId
      Translated hl7FieldSubfieldIdTran = await translateString(item.hl7FieldSubfieldId, item.hl7FieldSubfieldIdVi, item.hl7FieldSubfieldIdZh);
      if (hl7FieldSubfieldIdTran.translated) {
        item.hl7FieldSubfieldIdVi = hl7FieldSubfieldIdTran.translatedVi;
        item.hl7FieldSubfieldIdZh = hl7FieldSubfieldIdTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate externalCopyrightNotice
      Translated externalCopyrightNoticeTran = await translateString(
        item.externalCopyrightNotice,
        item.externalCopyrightNoticeVi,
        item.externalCopyrightNoticeZh,
      );
      if (externalCopyrightNoticeTran.translated) {
        item.externalCopyrightNoticeVi = externalCopyrightNoticeTran.translatedVi;
        item.externalCopyrightNoticeZh = externalCopyrightNoticeTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate exampleUnits
      Translated exampleUnitsTran = await translateString(item.exampleUnits, item.exampleUnitsVi, item.exampleUnitsZh);
      if (exampleUnitsTran.translated) {
        item.exampleUnitsVi = exampleUnitsTran.translatedVi;
        item.exampleUnitsZh = exampleUnitsTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate exampleUcumUnits
      Translated exampleUcumUnitsTran = await translateString(item.exampleUcumUnits, item.exampleUcumUnitsVi, item.exampleUcumUnitsZh);
      if (exampleUcumUnitsTran.translated) {
        item.exampleUcumUnitsVi = exampleUcumUnitsTran.translatedVi;
        item.exampleUcumUnitsZh = exampleUcumUnitsTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate statusReason
      Translated statusReasonTran = await translateString(item.statusReason, item.statusReasonVi, item.statusReasonZh);
      if (statusReasonTran.translated) {
        item.statusReasonVi = statusReasonTran.translatedVi;
        item.statusReasonZh = statusReasonTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate statusText
      Translated statusTextTran = await translateString(item.statusText, item.statusTextVi, item.statusTextZh);
      if (statusTextTran.translated) {
        item.statusTextVi = statusTextTran.translatedVi;
        item.statusTextZh = statusTextTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate changeReasonPublic
      Translated changeReasonPublicTran = await translateString(item.changeReasonPublic, item.changeReasonPublicVi, item.changeReasonPublicZh);
      if (changeReasonPublicTran.translated) {
        item.changeReasonPublicVi = changeReasonPublicTran.translatedVi;
        item.changeReasonPublicZh = changeReasonPublicTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate commonTestRank
      Translated commonTestRankTran = await translateString(item.commonTestRank, item.commonTestRankVi, item.commonTestRankZh);
      if (commonTestRankTran.translated) {
        item.commonTestRankVi = commonTestRankTran.translatedVi;
        item.commonTestRankZh = commonTestRankTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate commonOrderRank
      Translated commonOrderRankTran = await translateString(item.commonOrderRank, item.commonOrderRankVi, item.commonOrderRankZh);
      if (commonOrderRankTran.translated) {
        item.commonOrderRankVi = commonOrderRankTran.translatedVi;
        item.commonOrderRankZh = commonOrderRankTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate hl7AttachmentStructure
      Translated hl7AttachmentStructureTran = await translateString(item.hl7AttachmentStructure, item.hl7AttachmentStructureVi, item.hl7AttachmentStructureZh);
      if (hl7AttachmentStructureTran.translated) {
        item.hl7AttachmentStructureVi = hl7AttachmentStructureTran.translatedVi;
        item.hl7AttachmentStructureZh = hl7AttachmentStructureTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate externalCopyrightLink
      Translated externalCopyrightLinkTran = await translateString(item.externalCopyrightLink, item.externalCopyrightLinkVi, item.externalCopyrightLinkZh);
      if (externalCopyrightLinkTran.translated) {
        item.externalCopyrightLinkVi = externalCopyrightLinkTran.translatedVi;
        item.externalCopyrightLinkZh = externalCopyrightLinkTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate panelType
      Translated panelTypeTran = await translateString(item.panelType, item.panelTypeVi, item.panelTypeZh);
      if (panelTypeTran.translated) {
        item.panelTypeVi = panelTypeTran.translatedVi;
        item.panelTypeZh = panelTypeTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate askAtOrderEntry
      Translated askAtOrderEntryTran = await translateString(item.askAtOrderEntry, item.askAtOrderEntryVi, item.askAtOrderEntryZh);
      if (askAtOrderEntryTran.translated) {
        item.askAtOrderEntryVi = askAtOrderEntryTran.translatedVi;
        item.askAtOrderEntryZh = askAtOrderEntryTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate associatedObservations
      Translated associatedObservationsTran = await translateString(item.associatedObservations, item.associatedObservationsVi, item.associatedObservationsZh);
      if (associatedObservationsTran.translated) {
        item.associatedObservationsVi = associatedObservationsTran.translatedVi;
        item.associatedObservationsZh = associatedObservationsTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate versionFirstReleased
      Translated versionFirstReleasedTran = await translateString(item.versionFirstReleased, item.versionFirstReleasedVi, item.versionFirstReleasedZh);
      if (versionFirstReleasedTran.translated) {
        item.versionFirstReleasedVi = versionFirstReleasedTran.translatedVi;
        item.versionFirstReleasedZh = versionFirstReleasedTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate validHl7AttachmentRequest
      Translated validHl7AttachmentRequestTran = await translateString(
        item.validHl7AttachmentRequest,
        item.validHl7AttachmentRequestVi,
        item.validHl7AttachmentRequestZh,
      );
      if (validHl7AttachmentRequestTran.translated) {
        item.validHl7AttachmentRequestVi = validHl7AttachmentRequestTran.translatedVi;
        item.validHl7AttachmentRequestZh = validHl7AttachmentRequestTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate versionLastChanged
      Translated versionLastChangedTran = await translateString(item.versionLastChanged, item.versionLastChangedVi, item.versionLastChangedZh);
      if (versionLastChangedTran.translated) {
        item.versionLastChangedVi = versionLastChangedTran.translatedVi;
        item.versionLastChangedZh = versionLastChangedTran.translatedZh;
        needsUpdate = true;
      }

      // Check and translate chngType
      Translated chngTypeTran = await translateString(item.chngType, item.chngTypeVi, item.chngTypeZh);
      if (chngTypeTran.translated) {
        item.chngTypeVi = chngTypeTran.translatedVi;
        item.chngTypeZh = chngTypeTran.translatedZh;
        needsUpdate = true;
      }

      if (needsUpdate) {
        print("Updating item: ${item.loincNum}");
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
        print('Error translating component to Vietnamese: $e');
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
        print('Error translating component to Chinese: $e');
      }
    } else if (translatedZh.isEmpty && original.isNotEmpty) {
      translatedZh = original; // Fallback to original if translation fails
      translated = true;
    }
    return Translated(translatedVi: translatedVi, translatedZh: translatedZh, translated: translated);
  }

  bool _updateItem(LoincItemModel item) {
    if (item.loincNum.isEmpty) {
      return false; // Cannot update item without a LOINC number
    }
    try {
      SqliteController.instance.db.execute(updateQuery, item.getValueList());
      return true;
    } catch (e) {
      print('Error updating item: $e');
      return false; // Item not found or update failed
    }
  }

  Response getLoincItem(Request request, String loincNum) {
    final item = SqliteController.instance.db.select(selectItemQuery, [loincNum.trim()]);
    if (item.isEmpty) {
      return Response.notFound('LOINC item not found');
    }
    final loincItem = LoincItemModel.fromMap(item.first);
    return Response.ok(loincItem.toJson(), headers: {'Content-Type': 'application/json'});
  }

  String searchQuery = '';

  String updateQuery = '';

  String selectItemQuery = '''SELECT * FROM ${Variables.instance.lonicTable} WHERE ${LoincItemModel.loincNumStr} = ?''';

  String _createUpdateSubQuery() {
    StringBuffer subQuery = StringBuffer();
    for (String columnName in LoincItemModel.loincFieldConstants) {
      if (columnName == LoincItemModel.loincNumStr) continue; // Skip loincNum as it is used in WHERE clause
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
    for (String columnName in LoincItemModel.loincFieldConstants) {
      subQuery.write('$columnName LIKE ? OR ');
    }
    String subQueryStr = subQuery.toString();
    if (subQueryStr.isNotEmpty) {
      subQueryStr = subQueryStr.substring(0, subQueryStr.length - 4);
    }
    return subQueryStr;
  }

  List<String> _getListSearchString(String searchStr) {
    var listSearchString = List.generate(LoincItemModel.loincFieldConstants.length, (index) => '%$searchStr%');
    return listSearchString;
  }
}
