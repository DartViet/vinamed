import 'dart:io';

import 'package:webserver/update_server/queries.dart';
import 'package:webserver/update_server/sqlite_controller.dart';

class Loinc {
  static Loinc? _instance;

  Loinc._internal();

  static Loinc get instance {
    _instance ??= Loinc._internal();
    return _instance!;
  }

  void _insertItemToDatabase(LoincItem item, String tableName) {
    SqliteController.instance.db.execute(Queries.instance.getLoincUpsertValue(tableName), [
      item.loincNum,
      item.component,
      item.property,
      item.timeAspct,
      item.system,
      item.scaleTyp,
      item.methodTyp,
      item.clazz,
      item.versionLastChanged,
      item.chngType,
      item.definitionDescription,
      item.status,
      item.consumerName,
      item.classtype,
      item.formula,
      item.exmplAnswers,
      item.surveyQuestText,
      item.surveyQuestSrc,
      item.unitsrequired,
      item.relatednames2,
      item.shortname,
      item.orderObs,
      item.hl7FieldSubfieldId,
      item.externalCopyrightNotice,
      item.exampleUnits,
      item.longCommonName,
      item.exampleUcumUnits,
      item.statusReason,
      item.statusText,
      item.changeReasonPublic,
      item.commonTestRank,
      item.commonOrderRank,
      item.hl7AttachmentStructure,
      item.externalCopyrightLink,
      item.panelType,
      item.askAtOrderEntry,
      item.associatedObservations,
      item.versionFirstReleased,
      item.validHl7AttachmentRequest,
      item.displayName,
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
        final item = LoincItem.fromCsvLine(line);
        if (item.loincNum.isNotEmpty) {
          _insertItemToDatabase(item, tableName);
        }
      }
    }
  }
}

class LoincItem {
  String loincNum = '';
  String component = '';
  String property = '';
  String timeAspct = '';
  String system = '';
  String scaleTyp = '';
  String methodTyp = '';
  String clazz = '';
  String versionLastChanged = '';
  String chngType = '';
  String definitionDescription = '';
  String status = '';
  String consumerName = '';
  String classtype = '';
  String formula = '';
  String exmplAnswers = '';
  String surveyQuestText = '';
  String surveyQuestSrc = '';
  String unitsrequired = '';
  String relatednames2 = '';
  String shortname = '';
  String orderObs = '';
  String hl7FieldSubfieldId = '';
  String externalCopyrightNotice = '';
  String exampleUnits = '';
  String longCommonName = '';
  String exampleUcumUnits = '';
  String statusReason = '';
  String statusText = '';
  String changeReasonPublic = '';
  String commonTestRank = '';
  String commonOrderRank = '';
  String hl7AttachmentStructure = '';
  String externalCopyrightLink = '';
  String panelType = '';
  String askAtOrderEntry = '';
  String associatedObservations = '';
  String versionFirstReleased = '';
  String validHl7AttachmentRequest = '';
  String displayName = '';

  LoincItem();

  LoincItem.fromCsvLine(String csvLine) {
    // Parse CSV line, handling quoted fields
    List<String> fields = _parseCsvLine(csvLine);

    if (fields.length >= 40) {
      loincNum = fields[0].trim();
      component = fields[1].trim();
      property = fields[2].trim();
      timeAspct = fields[3].trim();
      system = fields[4].trim();
      scaleTyp = fields[5].trim();
      methodTyp = fields[6].trim();
      clazz = fields[7].trim();
      versionLastChanged = fields[8].trim();
      chngType = fields[9].trim();
      definitionDescription = fields[10].trim();
      status = fields[11].trim();
      consumerName = fields[12].trim();
      classtype = fields[13].trim();
      formula = fields[14].trim();
      exmplAnswers = fields[15].trim();
      surveyQuestText = fields[16].trim();
      surveyQuestSrc = fields[17].trim();
      unitsrequired = fields[18].trim();
      relatednames2 = fields[19].trim();
      shortname = fields[20].trim();
      orderObs = fields[21].trim();
      hl7FieldSubfieldId = fields[22].trim();
      externalCopyrightNotice = fields[23].trim();
      exampleUnits = fields[24].trim();
      longCommonName = fields[25].trim();
      exampleUcumUnits = fields[26].trim();
      statusReason = fields[27].trim();
      statusText = fields[28].trim();
      changeReasonPublic = fields[29].trim();
      commonTestRank = fields[30].trim();
      commonOrderRank = fields[31].trim();
      hl7AttachmentStructure = fields[32].trim();
      externalCopyrightLink = fields[33].trim();
      panelType = fields[34].trim();
      askAtOrderEntry = fields[35].trim();
      associatedObservations = fields[36].trim();
      versionFirstReleased = fields[37].trim();
      validHl7AttachmentRequest = fields[38].trim();
      displayName = fields[39].trim();
    }
  }

  List<String> _parseCsvLine(String line) {
    List<String> result = [];
    bool inQuotes = false;
    String currentField = '';

    for (int i = 0; i < line.length; i++) {
      String char = line[i];

      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        result.add(currentField);
        currentField = '';
      } else {
        currentField += char;
      }
    }

    // Add the last field
    result.add(currentField);

    return result;
  }
}
