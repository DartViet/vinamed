class Queries {
  static Queries? _instance;

  Queries._internal();

  static Queries get instance {
    _instance ??= Queries._internal();
    return _instance!;
  }

  // This method creates ICD-10-CM, ICD-10-PCS, and DHS tables
  String getCreateIcd10(String type) {
    String createIcd10Table =
        '''
    CREATE TABLE IF NOT EXISTS $type (
      id INTEGER UNIQUE NOT NULL,
      code TEXT UNIQUE NOT NULL,
      description_en TEXT,
      description_vi TEXT,
      description_zh TEXT,
      PRIMARY KEY (id AUTOINCREMENT)
    );
  ''';
    return createIcd10Table;
  }

  String getUpsertValue(String type) {
    return '''
    INSERT INTO $type (code, description_en, description_vi, description_zh)
    VALUES (?, ?, ?, ?)
    ON CONFLICT(code) DO UPDATE SET
      description_vi = CASE 
        WHEN $type.description_en = excluded.description_en THEN $type.description_vi 
        ELSE '' 
      END,
      description_zh = CASE 
        WHEN $type.description_en = excluded.description_en THEN $type.description_zh 
        ELSE '' 
      END,
      description_en = excluded.description_en;
  ''';
  }

  String createLoincTable(String tableName) {
    return '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,
      LOINC_NUM TEXT UNIQUE NOT NULL,
      COMPONENT TEXT,
      COMPONENT_VI TEXT,
      COMPONENT_ZH TEXT,
      PROPERTY TEXT,
      PROPERTY_VI TEXT,
      PROPERTY_ZH TEXT,
      TIME_ASPCT TEXT,
      TIME_ASPCT_VI TEXT,
      TIME_ASPCT_ZH TEXT,
      SYSTEM TEXT,
      SYSTEM_VI TEXT,
      SYSTEM_ZH TEXT,
      SCALE_TYP TEXT,
      SCALE_TYP_VI TEXT,
      SCALE_TYP_ZH TEXT,
      METHOD_TYP TEXT,
      METHOD_TYP_VI TEXT,
      METHOD_TYP_ZH TEXT,
      CLASS TEXT,
      CLASS_VI TEXT,
      CLASS_ZH TEXT,
      VersionLastChanged TEXT,
      VersionLastChanged_VI TEXT,
      VersionLastChanged_ZH TEXT,
      CHNG_TYPE TEXT,
      CHNG_TYPE_VI TEXT,
      CHNG_TYPE_ZH TEXT,
      DefinitionDescription TEXT,
      DefinitionDescription_VI TEXT,
      DefinitionDescription_ZH TEXT,
      STATUS TEXT,
      STATUS_VI TEXT,
      STATUS_ZH TEXT,
      CONSUMER_NAME TEXT,
      CONSUMER_NAME_VI TEXT,
      CONSUMER_NAME_ZH TEXT,
      CLASSTYPE TEXT,
      CLASSTYPE_VI TEXT,
      CLASSTYPE_ZH TEXT,
      FORMULA TEXT,
      FORMULA_VI TEXT,
      FORMULA_ZH TEXT,
      EXMPL_ANSWERS TEXT,
      EXMPL_ANSWERS_VI TEXT,
      EXMPL_ANSWERS_ZH TEXT,
      SURVEY_QUEST_TEXT TEXT,
      SURVEY_QUEST_TEXT_VI TEXT,
      SURVEY_QUEST_TEXT_ZH TEXT,
      SURVEY_QUEST_SRC TEXT,
      SURVEY_QUEST_SRC_VI TEXT,
      SURVEY_QUEST_SRC_ZH TEXT,
      UNITSREQUIRED TEXT,
      UNITSREQUIRED_VI TEXT,
      UNITSREQUIRED_ZH TEXT,
      RELATEDNAMES2 TEXT,
      RELATEDNAMES2_VI TEXT,
      RELATEDNAMES2_ZH TEXT,
      SHORTNAME TEXT,
      SHORTNAME_VI TEXT,
      SHORTNAME_ZH TEXT,
      ORDER_OBS TEXT,
      ORDER_OBS_VI TEXT,
      ORDER_OBS_ZH TEXT,
      HL7_FIELD_SUBFIELD_ID TEXT,
      HL7_FIELD_SUBFIELD_ID_VI TEXT,
      HL7_FIELD_SUBFIELD_ID_ZH TEXT,
      EXTERNAL_COPYRIGHT_NOTICE TEXT,
      EXTERNAL_COPYRIGHT_NOTICE_VI TEXT,
      EXTERNAL_COPYRIGHT_NOTICE_ZH TEXT,
      EXAMPLE_UNITS TEXT,
      EXAMPLE_UNITS_VI TEXT,
      EXAMPLE_UNITS_ZH TEXT,
      LONG_COMMON_NAME TEXT,
      LONG_COMMON_NAME_VI TEXT,
      LONG_COMMON_NAME_ZH TEXT,
      EXAMPLE_UCUM_UNITS TEXT,
      EXAMPLE_UCUM_UNITS_VI TEXT,
      EXAMPLE_UCUM_UNITS_ZH TEXT,
      STATUS_REASON TEXT,
      STATUS_REASON_VI TEXT,
      STATUS_REASON_ZH TEXT,
      STATUS_TEXT TEXT,
      STATUS_TEXT_VI TEXT,
      STATUS_TEXT_ZH TEXT,
      CHANGE_REASON_PUBLIC TEXT,
      CHANGE_REASON_PUBLIC_VI TEXT,
      CHANGE_REASON_PUBLIC_ZH TEXT,
      COMMON_TEST_RANK TEXT,
      COMMON_TEST_RANK_VI TEXT,
      COMMON_TEST_RANK_ZH TEXT,
      COMMON_ORDER_RANK TEXT,
      COMMON_ORDER_RANK_VI TEXT,
      COMMON_ORDER_RANK_ZH TEXT,
      HL7_ATTACHMENT_STRUCTURE TEXT,
      HL7_ATTACHMENT_STRUCTURE_VI TEXT,
      HL7_ATTACHMENT_STRUCTURE_ZH TEXT,
      EXTERNAL_COPYRIGHT_LINK TEXT,
      EXTERNAL_COPYRIGHT_LINK_VI TEXT,
      EXTERNAL_COPYRIGHT_LINK_ZH TEXT,
      PanelType TEXT,
      PanelType_VI TEXT,
      PanelType_ZH TEXT,
      AskAtOrderEntry TEXT,
      AskAtOrderEntry_VI TEXT,
      AskAtOrderEntry_ZH TEXT,
      AssociatedObservations TEXT,
      AssociatedObservations_VI TEXT,
      AssociatedObservations_ZH TEXT,
      VersionFirstReleased TEXT,
      VersionFirstReleased_VI TEXT,
      VersionFirstReleased_ZH TEXT,
      ValidHL7AttachmentRequest TEXT,
      ValidHL7AttachmentRequest_VI TEXT,
      ValidHL7AttachmentRequest_ZH TEXT,
      DisplayName TEXT,
      DisplayName_VI TEXT,
      DisplayName_ZH TEXT
    );
  ''';
  }

  String getLoincUpsertValue(String tableName) {
    return '''
    INSERT INTO $tableName (
      LOINC_NUM, COMPONENT, PROPERTY, TIME_ASPCT, SYSTEM, SCALE_TYP, METHOD_TYP, CLASS,
      VersionLastChanged, CHNG_TYPE, DefinitionDescription, STATUS, CONSUMER_NAME, CLASSTYPE,
      FORMULA, EXMPL_ANSWERS, SURVEY_QUEST_TEXT, SURVEY_QUEST_SRC, UNITSREQUIRED, RELATEDNAMES2,
      SHORTNAME, ORDER_OBS, HL7_FIELD_SUBFIELD_ID, EXTERNAL_COPYRIGHT_NOTICE, EXAMPLE_UNITS,
      LONG_COMMON_NAME, EXAMPLE_UCUM_UNITS, STATUS_REASON, STATUS_TEXT, CHANGE_REASON_PUBLIC,
      COMMON_TEST_RANK, COMMON_ORDER_RANK, HL7_ATTACHMENT_STRUCTURE, EXTERNAL_COPYRIGHT_LINK,
      PanelType, AskAtOrderEntry, AssociatedObservations, VersionFirstReleased, ValidHL7AttachmentRequest, DisplayName
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(LOINC_NUM) DO UPDATE SET
      COMPONENT_VI = CASE WHEN $tableName.COMPONENT = excluded.COMPONENT THEN $tableName.COMPONENT_VI ELSE '' END,
      COMPONENT_ZH = CASE WHEN $tableName.COMPONENT = excluded.COMPONENT THEN $tableName.COMPONENT_ZH ELSE '' END,
      PROPERTY_VI = CASE WHEN $tableName.PROPERTY = excluded.PROPERTY THEN $tableName.PROPERTY_VI ELSE '' END,
      PROPERTY_ZH = CASE WHEN $tableName.PROPERTY = excluded.PROPERTY THEN $tableName.PROPERTY_ZH ELSE '' END,
      TIME_ASPCT_VI = CASE WHEN $tableName.TIME_ASPCT = excluded.TIME_ASPCT THEN $tableName.TIME_ASPCT_VI ELSE '' END,
      TIME_ASPCT_ZH = CASE WHEN $tableName.TIME_ASPCT = excluded.TIME_ASPCT THEN $tableName.TIME_ASPCT_ZH ELSE '' END,
      SYSTEM_VI = CASE WHEN $tableName.SYSTEM = excluded.SYSTEM THEN $tableName.SYSTEM_VI ELSE '' END,
      SYSTEM_ZH = CASE WHEN $tableName.SYSTEM = excluded.SYSTEM THEN $tableName.SYSTEM_ZH ELSE '' END,
      SCALE_TYP_VI = CASE WHEN $tableName.SCALE_TYP = excluded.SCALE_TYP THEN $tableName.SCALE_TYP_VI ELSE '' END,
      SCALE_TYP_ZH = CASE WHEN $tableName.SCALE_TYP = excluded.SCALE_TYP THEN $tableName.SCALE_TYP_ZH ELSE '' END,
      METHOD_TYP_VI = CASE WHEN $tableName.METHOD_TYP = excluded.METHOD_TYP THEN $tableName.METHOD_TYP_VI ELSE '' END,
      METHOD_TYP_ZH = CASE WHEN $tableName.METHOD_TYP = excluded.METHOD_TYP THEN $tableName.METHOD_TYP_ZH ELSE '' END,
      CLASS_VI = CASE WHEN $tableName.CLASS = excluded.CLASS THEN $tableName.CLASS_VI ELSE '' END,
      CLASS_ZH = CASE WHEN $tableName.CLASS = excluded.CLASS THEN $tableName.CLASS_ZH ELSE '' END,
      VersionLastChanged_VI = CASE WHEN $tableName.VersionLastChanged = excluded.VersionLastChanged THEN $tableName.VersionLastChanged_VI ELSE '' END,
      VersionLastChanged_ZH = CASE WHEN $tableName.VersionLastChanged = excluded.VersionLastChanged THEN $tableName.VersionLastChanged_ZH ELSE '' END,
      CHNG_TYPE_VI = CASE WHEN $tableName.CHNG_TYPE = excluded.CHNG_TYPE THEN $tableName.CHNG_TYPE_VI ELSE '' END,
      CHNG_TYPE_ZH = CASE WHEN $tableName.CHNG_TYPE = excluded.CHNG_TYPE THEN $tableName.CHNG_TYPE_ZH ELSE '' END,
      DefinitionDescription_VI = CASE WHEN $tableName.DefinitionDescription = excluded.DefinitionDescription THEN $tableName.DefinitionDescription_VI ELSE '' END,
      DefinitionDescription_ZH = CASE WHEN $tableName.DefinitionDescription = excluded.DefinitionDescription THEN $tableName.DefinitionDescription_ZH ELSE '' END,
      STATUS_VI = CASE WHEN $tableName.STATUS = excluded.STATUS THEN $tableName.STATUS_VI ELSE '' END,
      STATUS_ZH = CASE WHEN $tableName.STATUS = excluded.STATUS THEN $tableName.STATUS_ZH ELSE '' END,
      CONSUMER_NAME_VI = CASE WHEN $tableName.CONSUMER_NAME = excluded.CONSUMER_NAME THEN $tableName.CONSUMER_NAME_VI ELSE '' END,
      CONSUMER_NAME_ZH = CASE WHEN $tableName.CONSUMER_NAME = excluded.CONSUMER_NAME THEN $tableName.CONSUMER_NAME_ZH ELSE '' END,
      CLASSTYPE_VI = CASE WHEN $tableName.CLASSTYPE = excluded.CLASSTYPE THEN $tableName.CLASSTYPE_VI ELSE '' END,
      CLASSTYPE_ZH = CASE WHEN $tableName.CLASSTYPE = excluded.CLASSTYPE THEN $tableName.CLASSTYPE_ZH ELSE '' END,
      FORMULA_VI = CASE WHEN $tableName.FORMULA = excluded.FORMULA THEN $tableName.FORMULA_VI ELSE '' END,
      FORMULA_ZH = CASE WHEN $tableName.FORMULA = excluded.FORMULA THEN $tableName.FORMULA_ZH ELSE '' END,
      EXMPL_ANSWERS_VI = CASE WHEN $tableName.EXMPL_ANSWERS = excluded.EXMPL_ANSWERS THEN $tableName.EXMPL_ANSWERS_VI ELSE '' END,
      EXMPL_ANSWERS_ZH = CASE WHEN $tableName.EXMPL_ANSWERS = excluded.EXMPL_ANSWERS THEN $tableName.EXMPL_ANSWERS_ZH ELSE '' END,
      SURVEY_QUEST_TEXT_VI = CASE WHEN $tableName.SURVEY_QUEST_TEXT = excluded.SURVEY_QUEST_TEXT THEN $tableName.SURVEY_QUEST_TEXT_VI ELSE '' END,
      SURVEY_QUEST_TEXT_ZH = CASE WHEN $tableName.SURVEY_QUEST_TEXT = excluded.SURVEY_QUEST_TEXT THEN $tableName.SURVEY_QUEST_TEXT_ZH ELSE '' END,
      SURVEY_QUEST_SRC_VI = CASE WHEN $tableName.SURVEY_QUEST_SRC = excluded.SURVEY_QUEST_SRC THEN $tableName.SURVEY_QUEST_SRC_VI ELSE '' END,
      SURVEY_QUEST_SRC_ZH = CASE WHEN $tableName.SURVEY_QUEST_SRC = excluded.SURVEY_QUEST_SRC THEN $tableName.SURVEY_QUEST_SRC_ZH ELSE '' END,
      UNITSREQUIRED_VI = CASE WHEN $tableName.UNITSREQUIRED = excluded.UNITSREQUIRED THEN $tableName.UNITSREQUIRED_VI ELSE '' END,
      UNITSREQUIRED_ZH = CASE WHEN $tableName.UNITSREQUIRED = excluded.UNITSREQUIRED THEN $tableName.UNITSREQUIRED_ZH ELSE '' END,
      RELATEDNAMES2_VI = CASE WHEN $tableName.RELATEDNAMES2 = excluded.RELATEDNAMES2 THEN $tableName.RELATEDNAMES2_VI ELSE '' END,
      RELATEDNAMES2_ZH = CASE WHEN $tableName.RELATEDNAMES2 = excluded.RELATEDNAMES2 THEN $tableName.RELATEDNAMES2_ZH ELSE '' END,
      SHORTNAME_VI = CASE WHEN $tableName.SHORTNAME = excluded.SHORTNAME THEN $tableName.SHORTNAME_VI ELSE '' END,
      SHORTNAME_ZH = CASE WHEN $tableName.SHORTNAME = excluded.SHORTNAME THEN $tableName.SHORTNAME_ZH ELSE '' END,
      ORDER_OBS_VI = CASE WHEN $tableName.ORDER_OBS = excluded.ORDER_OBS THEN $tableName.ORDER_OBS_VI ELSE '' END,
      ORDER_OBS_ZH = CASE WHEN $tableName.ORDER_OBS = excluded.ORDER_OBS THEN $tableName.ORDER_OBS_ZH ELSE '' END,
      HL7_FIELD_SUBFIELD_ID_VI = CASE WHEN $tableName.HL7_FIELD_SUBFIELD_ID = excluded.HL7_FIELD_SUBFIELD_ID THEN $tableName.HL7_FIELD_SUBFIELD_ID_VI ELSE '' END,
      HL7_FIELD_SUBFIELD_ID_ZH = CASE WHEN $tableName.HL7_FIELD_SUBFIELD_ID = excluded.HL7_FIELD_SUBFIELD_ID THEN $tableName.HL7_FIELD_SUBFIELD_ID_ZH ELSE '' END,
      EXTERNAL_COPYRIGHT_NOTICE_VI = CASE WHEN $tableName.EXTERNAL_COPYRIGHT_NOTICE = excluded.EXTERNAL_COPYRIGHT_NOTICE THEN $tableName.EXTERNAL_COPYRIGHT_NOTICE_VI ELSE '' END,
      EXTERNAL_COPYRIGHT_NOTICE_ZH = CASE WHEN $tableName.EXTERNAL_COPYRIGHT_NOTICE = excluded.EXTERNAL_COPYRIGHT_NOTICE THEN $tableName.EXTERNAL_COPYRIGHT_NOTICE_ZH ELSE '' END,
      EXAMPLE_UNITS_VI = CASE WHEN $tableName.EXAMPLE_UNITS = excluded.EXAMPLE_UNITS THEN $tableName.EXAMPLE_UNITS_VI ELSE '' END,
      EXAMPLE_UNITS_ZH = CASE WHEN $tableName.EXAMPLE_UNITS = excluded.EXAMPLE_UNITS THEN $tableName.EXAMPLE_UNITS_ZH ELSE '' END,
      LONG_COMMON_NAME_VI = CASE WHEN $tableName.LONG_COMMON_NAME = excluded.LONG_COMMON_NAME THEN $tableName.LONG_COMMON_NAME_VI ELSE '' END,
      LONG_COMMON_NAME_ZH = CASE WHEN $tableName.LONG_COMMON_NAME = excluded.LONG_COMMON_NAME THEN $tableName.LONG_COMMON_NAME_ZH ELSE '' END,
      EXAMPLE_UCUM_UNITS_VI = CASE WHEN $tableName.EXAMPLE_UCUM_UNITS = excluded.EXAMPLE_UCUM_UNITS THEN $tableName.EXAMPLE_UCUM_UNITS_VI ELSE '' END,
      EXAMPLE_UCUM_UNITS_ZH = CASE WHEN $tableName.EXAMPLE_UCUM_UNITS = excluded.EXAMPLE_UCUM_UNITS THEN $tableName.EXAMPLE_UCUM_UNITS_ZH ELSE '' END,
      STATUS_REASON_VI = CASE WHEN $tableName.STATUS_REASON = excluded.STATUS_REASON THEN $tableName.STATUS_REASON_VI ELSE '' END,
      STATUS_REASON_ZH = CASE WHEN $tableName.STATUS_REASON = excluded.STATUS_REASON THEN $tableName.STATUS_REASON_ZH ELSE '' END,
      STATUS_TEXT_VI = CASE WHEN $tableName.STATUS_TEXT = excluded.STATUS_TEXT THEN $tableName.STATUS_TEXT_VI ELSE '' END,
      STATUS_TEXT_ZH = CASE WHEN $tableName.STATUS_TEXT = excluded.STATUS_TEXT THEN $tableName.STATUS_TEXT_ZH ELSE '' END,
      CHANGE_REASON_PUBLIC_VI = CASE WHEN $tableName.CHANGE_REASON_PUBLIC = excluded.CHANGE_REASON_PUBLIC THEN $tableName.CHANGE_REASON_PUBLIC_VI ELSE '' END,
      CHANGE_REASON_PUBLIC_ZH = CASE WHEN $tableName.CHANGE_REASON_PUBLIC = excluded.CHANGE_REASON_PUBLIC THEN $tableName.CHANGE_REASON_PUBLIC_ZH ELSE '' END,
      COMMON_TEST_RANK_VI = CASE WHEN $tableName.COMMON_TEST_RANK = excluded.COMMON_TEST_RANK THEN $tableName.COMMON_TEST_RANK_VI ELSE '' END,
      COMMON_TEST_RANK_ZH = CASE WHEN $tableName.COMMON_TEST_RANK = excluded.COMMON_TEST_RANK THEN $tableName.COMMON_TEST_RANK_ZH ELSE '' END,
      COMMON_ORDER_RANK_VI = CASE WHEN $tableName.COMMON_ORDER_RANK = excluded.COMMON_ORDER_RANK THEN $tableName.COMMON_ORDER_RANK_VI ELSE '' END,
      COMMON_ORDER_RANK_ZH = CASE WHEN $tableName.COMMON_ORDER_RANK = excluded.COMMON_ORDER_RANK THEN $tableName.COMMON_ORDER_RANK_ZH ELSE '' END,
      HL7_ATTACHMENT_STRUCTURE_VI = CASE WHEN $tableName.HL7_ATTACHMENT_STRUCTURE = excluded.HL7_ATTACHMENT_STRUCTURE THEN $tableName.HL7_ATTACHMENT_STRUCTURE_VI ELSE '' END,
      HL7_ATTACHMENT_STRUCTURE_ZH = CASE WHEN $tableName.HL7_ATTACHMENT_STRUCTURE = excluded.HL7_ATTACHMENT_STRUCTURE THEN $tableName.HL7_ATTACHMENT_STRUCTURE_ZH ELSE '' END,
      EXTERNAL_COPYRIGHT_LINK_VI = CASE WHEN $tableName.EXTERNAL_COPYRIGHT_LINK = excluded.EXTERNAL_COPYRIGHT_LINK THEN $tableName.EXTERNAL_COPYRIGHT_LINK_VI ELSE '' END,
      EXTERNAL_COPYRIGHT_LINK_ZH = CASE WHEN $tableName.EXTERNAL_COPYRIGHT_LINK = excluded.EXTERNAL_COPYRIGHT_LINK THEN $tableName.EXTERNAL_COPYRIGHT_LINK_ZH ELSE '' END,
      PanelType_VI = CASE WHEN $tableName.PanelType = excluded.PanelType THEN $tableName.PanelType_VI ELSE '' END,
      PanelType_ZH = CASE WHEN $tableName.PanelType = excluded.PanelType THEN $tableName.PanelType_ZH ELSE '' END,
      AskAtOrderEntry_VI = CASE WHEN $tableName.AskAtOrderEntry = excluded.AskAtOrderEntry THEN $tableName.AskAtOrderEntry_VI ELSE '' END,
      AskAtOrderEntry_ZH = CASE WHEN $tableName.AskAtOrderEntry = excluded.AskAtOrderEntry THEN $tableName.AskAtOrderEntry_ZH ELSE '' END,
      AssociatedObservations_VI = CASE WHEN $tableName.AssociatedObservations = excluded.AssociatedObservations THEN $tableName.AssociatedObservations_VI ELSE '' END,
      AssociatedObservations_ZH = CASE WHEN $tableName.AssociatedObservations = excluded.AssociatedObservations THEN $tableName.AssociatedObservations_ZH ELSE '' END,
      VersionFirstReleased_VI = CASE WHEN $tableName.VersionFirstReleased = excluded.VersionFirstReleased THEN $tableName.VersionFirstReleased_VI ELSE '' END,
      VersionFirstReleased_ZH = CASE WHEN $tableName.VersionFirstReleased = excluded.VersionFirstReleased THEN $tableName.VersionFirstReleased_ZH ELSE '' END,
      ValidHL7AttachmentRequest_VI = CASE WHEN $tableName.ValidHL7AttachmentRequest = excluded.ValidHL7AttachmentRequest THEN $tableName.ValidHL7AttachmentRequest_VI ELSE '' END,
      ValidHL7AttachmentRequest_ZH = CASE WHEN $tableName.ValidHL7AttachmentRequest = excluded.ValidHL7AttachmentRequest THEN $tableName.ValidHL7AttachmentRequest_ZH ELSE '' END,
      DisplayName_VI = CASE WHEN $tableName.DisplayName = excluded.DisplayName THEN $tableName.DisplayName_VI ELSE '' END,
      DisplayName_ZH = CASE WHEN $tableName.DisplayName = excluded.DisplayName THEN $tableName.DisplayName_ZH ELSE '' END,
      COMPONENT = excluded.COMPONENT,
      PROPERTY = excluded.PROPERTY,
      TIME_ASPCT = excluded.TIME_ASPCT,
      SYSTEM = excluded.SYSTEM,
      SCALE_TYP = excluded.SCALE_TYP,
      METHOD_TYP = excluded.METHOD_TYP,
      CLASS = excluded.CLASS,
      VersionLastChanged = excluded.VersionLastChanged,
      CHNG_TYPE = excluded.CHNG_TYPE,
      DefinitionDescription = excluded.DefinitionDescription,
      STATUS = excluded.STATUS,
      CONSUMER_NAME = excluded.CONSUMER_NAME,
      CLASSTYPE = excluded.CLASSTYPE,
      FORMULA = excluded.FORMULA,
      EXMPL_ANSWERS = excluded.EXMPL_ANSWERS,
      SURVEY_QUEST_TEXT = excluded.SURVEY_QUEST_TEXT,
      SURVEY_QUEST_SRC = excluded.SURVEY_QUEST_SRC,
      UNITSREQUIRED = excluded.UNITSREQUIRED,
      RELATEDNAMES2 = excluded.RELATEDNAMES2,
      SHORTNAME = excluded.SHORTNAME,
      ORDER_OBS = excluded.ORDER_OBS,
      HL7_FIELD_SUBFIELD_ID = excluded.HL7_FIELD_SUBFIELD_ID,
      EXTERNAL_COPYRIGHT_NOTICE = excluded.EXTERNAL_COPYRIGHT_NOTICE,
      EXAMPLE_UNITS = excluded.EXAMPLE_UNITS,
      LONG_COMMON_NAME = excluded.LONG_COMMON_NAME,
      EXAMPLE_UCUM_UNITS = excluded.EXAMPLE_UCUM_UNITS,
      STATUS_REASON = excluded.STATUS_REASON,
      STATUS_TEXT = excluded.STATUS_TEXT,
      CHANGE_REASON_PUBLIC = excluded.CHANGE_REASON_PUBLIC,
      COMMON_TEST_RANK = excluded.COMMON_TEST_RANK,
      COMMON_ORDER_RANK = excluded.COMMON_ORDER_RANK,
      HL7_ATTACHMENT_STRUCTURE = excluded.HL7_ATTACHMENT_STRUCTURE,
      EXTERNAL_COPYRIGHT_LINK = excluded.EXTERNAL_COPYRIGHT_LINK,
      PanelType = excluded.PanelType,
      AskAtOrderEntry = excluded.AskAtOrderEntry,
      AssociatedObservations = excluded.AssociatedObservations,
      VersionFirstReleased = excluded.VersionFirstReleased,
      ValidHL7AttachmentRequest = excluded.ValidHL7AttachmentRequest,
      DisplayName = excluded.DisplayName;
  ''';
  }

  String createFdaDrugTable(String tableName) {
    return '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,
      ApplNo TEXT UNIQUE NOT NULL,
      ProductNo TEXT,
      ProductNo_VI TEXT,
      ProductNo_ZH TEXT,
      Form TEXT,
      Form_VI TEXT,
      Form_ZH TEXT,
      Strength TEXT,
      Strength_VI TEXT,
      Strength_ZH TEXT,
      ReferenceDrug TEXT,
      ReferenceDrug_VI TEXT,
      ReferenceDrug_ZH TEXT,
      DrugName TEXT,
      DrugName_VI TEXT,
      DrugName_ZH TEXT,
      ActiveIngredient TEXT,
      ActiveIngredient_VI TEXT,
      ActiveIngredient_ZH TEXT,
      ReferenceStandard TEXT,
      ReferenceStandard_VI TEXT,
      ReferenceStandard_ZH TEXT
    );
  ''';
  }

  String getFdaDrugUpsertValue(String tableName) {
    return '''
    INSERT INTO $tableName (
      ApplNo, ProductNo, Form, Strength, ReferenceDrug, DrugName, ActiveIngredient, ReferenceStandard
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(ApplNo) DO UPDATE SET
      ProductNo_VI = CASE WHEN $tableName.ProductNo = excluded.ProductNo THEN $tableName.ProductNo_VI ELSE '' END,
      ProductNo_ZH = CASE WHEN $tableName.ProductNo = excluded.ProductNo THEN $tableName.ProductNo_ZH ELSE '' END,
      Form_VI = CASE WHEN $tableName.Form = excluded.Form THEN $tableName.Form_VI ELSE '' END,
      Form_ZH = CASE WHEN $tableName.Form = excluded.Form THEN $tableName.Form_ZH ELSE '' END,
      Strength_VI = CASE WHEN $tableName.Strength = excluded.Strength THEN $tableName.Strength_VI ELSE '' END,
      Strength_ZH = CASE WHEN $tableName.Strength = excluded.Strength THEN $tableName.Strength_ZH ELSE '' END,
      ReferenceDrug_VI = CASE WHEN $tableName.ReferenceDrug = excluded.ReferenceDrug THEN $tableName.ReferenceDrug_VI ELSE '' END,
      ReferenceDrug_ZH = CASE WHEN $tableName.ReferenceDrug = excluded.ReferenceDrug THEN $tableName.ReferenceDrug_ZH ELSE '' END,
      DrugName_VI = CASE WHEN $tableName.DrugName = excluded.DrugName THEN $tableName.DrugName_VI ELSE '' END,
      DrugName_ZH = CASE WHEN $tableName.DrugName = excluded.DrugName THEN $tableName.DrugName_ZH ELSE '' END,
      ActiveIngredient_VI = CASE WHEN $tableName.ActiveIngredient = excluded.ActiveIngredient THEN $tableName.ActiveIngredient_VI ELSE '' END,
      ActiveIngredient_ZH = CASE WHEN $tableName.ActiveIngredient = excluded.ActiveIngredient THEN $tableName.ActiveIngredient_ZH ELSE '' END,
      ReferenceStandard_VI = CASE WHEN $tableName.ReferenceStandard = excluded.ReferenceStandard THEN $tableName.ReferenceStandard_VI ELSE '' END,
      ReferenceStandard_ZH = CASE WHEN $tableName.ReferenceStandard = excluded.ReferenceStandard THEN $tableName.ReferenceStandard_ZH ELSE '' END,
      ProductNo = excluded.ProductNo,
      Form = excluded.Form,
      Strength = excluded.Strength,
      ReferenceDrug = excluded.ReferenceDrug,
      DrugName = excluded.DrugName,
      ActiveIngredient = excluded.ActiveIngredient,
      ReferenceStandard = excluded.ReferenceStandard;
  ''';
  }
}
