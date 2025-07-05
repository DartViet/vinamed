class LoincItemModel {
  // Static field name constants
  static String idStr = 'id';
  static String loincNumStr = 'LOINC_NUM';
  static String componentStr = 'COMPONENT';
  static String componentViStr = 'COMPONENT_VI';
  static String componentZhStr = 'COMPONENT_ZH';
  static String propertyStr = 'PROPERTY';
  static String propertyViStr = 'PROPERTY_VI';
  static String propertyZhStr = 'PROPERTY_ZH';
  static String timeAspctStr = 'TIME_ASPCT';
  static String timeAspctViStr = 'TIME_ASPCT_VI';
  static String timeAspctZhStr = 'TIME_ASPCT_ZH';
  static String systemStr = 'SYSTEM';
  static String systemViStr = 'SYSTEM_VI';
  static String systemZhStr = 'SYSTEM_ZH';
  static String scaleTypStr = 'SCALE_TYP';
  static String scaleTypViStr = 'SCALE_TYP_VI';
  static String scaleTypZhStr = 'SCALE_TYP_ZH';
  static String methodTypStr = 'METHOD_TYP';
  static String methodTypViStr = 'METHOD_TYP_VI';
  static String methodTypZhStr = 'METHOD_TYP_ZH';
  static String classStr = 'CLASS';
  static String classViStr = 'CLASS_VI';
  static String classZhStr = 'CLASS_ZH';
  static String versionLastChangedStr = 'VersionLastChanged';
  static String versionLastChangedViStr = 'VersionLastChanged_VI';
  static String versionLastChangedZhStr = 'VersionLastChanged_ZH';
  static String chngTypeStr = 'CHNG_TYPE';
  static String chngTypeViStr = 'CHNG_TYPE_VI';
  static String chngTypeZhStr = 'CHNG_TYPE_ZH';
  static String definitionDescriptionStr = 'DefinitionDescription';
  static String definitionDescriptionViStr = 'DefinitionDescription_VI';
  static String definitionDescriptionZhStr = 'DefinitionDescription_ZH';
  static String statusStr = 'STATUS';
  static String statusViStr = 'STATUS_VI';
  static String statusZhStr = 'STATUS_ZH';
  static String consumerNameStr = 'CONSUMER_NAME';
  static String consumerNameViStr = 'CONSUMER_NAME_VI';
  static String consumerNameZhStr = 'CONSUMER_NAME_ZH';
  static String classTypeStr = 'CLASSTYPE';
  static String classTypeViStr = 'CLASSTYPE_VI';
  static String classTypeZhStr = 'CLASSTYPE_ZH';
  static String formulaStr = 'FORMULA';
  static String formulaViStr = 'FORMULA_VI';
  static String formulaZhStr = 'FORMULA_ZH';
  static String exmplAnswersStr = 'EXMPL_ANSWERS';
  static String exmplAnswersViStr = 'EXMPL_ANSWERS_VI';
  static String exmplAnswersZhStr = 'EXMPL_ANSWERS_ZH';
  static String surveyQuestTextStr = 'SURVEY_QUEST_TEXT';
  static String surveyQuestTextViStr = 'SURVEY_QUEST_TEXT_VI';
  static String surveyQuestTextZhStr = 'SURVEY_QUEST_TEXT_ZH';
  static String surveyQuestSrcStr = 'SURVEY_QUEST_SRC';
  static String surveyQuestSrcViStr = 'SURVEY_QUEST_SRC_VI';
  static String surveyQuestSrcZhStr = 'SURVEY_QUEST_SRC_ZH';
  static String unitsRequiredStr = 'UNITSREQUIRED';
  static String unitsRequiredViStr = 'UNITSREQUIRED_VI';
  static String unitsRequiredZhStr = 'UNITSREQUIRED_ZH';
  static String relatedNames2Str = 'RELATEDNAMES2';
  static String relatedNames2ViStr = 'RELATEDNAMES2_VI';
  static String relatedNames2ZhStr = 'RELATEDNAMES2_ZH';
  static String shortNameStr = 'SHORTNAME';
  static String shortNameViStr = 'SHORTNAME_VI';
  static String shortNameZhStr = 'SHORTNAME_ZH';
  static String orderObsStr = 'ORDER_OBS';
  static String orderObsViStr = 'ORDER_OBS_VI';
  static String orderObsZhStr = 'ORDER_OBS_ZH';
  static String hl7FieldSubfieldIdStr = 'HL7_FIELD_SUBFIELD_ID';
  static String hl7FieldSubfieldIdViStr = 'HL7_FIELD_SUBFIELD_ID_VI';
  static String hl7FieldSubfieldIdZhStr = 'HL7_FIELD_SUBFIELD_ID_ZH';
  static String externalCopyrightNoticeStr = 'EXTERNAL_COPYRIGHT_NOTICE';
  static String externalCopyrightNoticeViStr = 'EXTERNAL_COPYRIGHT_NOTICE_VI';
  static String externalCopyrightNoticeZhStr = 'EXTERNAL_COPYRIGHT_NOTICE_ZH';
  static String exampleUnitsStr = 'EXAMPLE_UNITS';
  static String exampleUnitsViStr = 'EXAMPLE_UNITS_VI';
  static String exampleUnitsZhStr = 'EXAMPLE_UNITS_ZH';
  static String longCommonNameStr = 'LONG_COMMON_NAME';
  static String longCommonNameViStr = 'LONG_COMMON_NAME_VI';
  static String longCommonNameZhStr = 'LONG_COMMON_NAME_ZH';
  static String exampleUcumUnitsStr = 'EXAMPLE_UCUM_UNITS';
  static String exampleUcumUnitsViStr = 'EXAMPLE_UCUM_UNITS_VI';
  static String exampleUcumUnitsZhStr = 'EXAMPLE_UCUM_UNITS_ZH';
  static String statusReasonStr = 'STATUS_REASON';
  static String statusReasonViStr = 'STATUS_REASON_VI';
  static String statusReasonZhStr = 'STATUS_REASON_ZH';
  static String statusTextStr = 'STATUS_TEXT';
  static String statusTextViStr = 'STATUS_TEXT_VI';
  static String statusTextZhStr = 'STATUS_TEXT_ZH';
  static String changeReasonPublicStr = 'CHANGE_REASON_PUBLIC';
  static String changeReasonPublicViStr = 'CHANGE_REASON_PUBLIC_VI';
  static String changeReasonPublicZhStr = 'CHANGE_REASON_PUBLIC_ZH';
  static String commonTestRankStr = 'COMMON_TEST_RANK';
  static String commonTestRankViStr = 'COMMON_TEST_RANK_VI';
  static String commonTestRankZhStr = 'COMMON_TEST_RANK_ZH';
  static String commonOrderRankStr = 'COMMON_ORDER_RANK';
  static String commonOrderRankViStr = 'COMMON_ORDER_RANK_VI';
  static String commonOrderRankZhStr = 'COMMON_ORDER_RANK_ZH';
  static String hl7AttachmentStructureStr = 'HL7_ATTACHMENT_STRUCTURE';
  static String hl7AttachmentStructureViStr = 'HL7_ATTACHMENT_STRUCTURE_VI';
  static String hl7AttachmentStructureZhStr = 'HL7_ATTACHMENT_STRUCTURE_ZH';
  static String externalCopyrightLinkStr = 'EXTERNAL_COPYRIGHT_LINK';
  static String externalCopyrightLinkViStr = 'EXTERNAL_COPYRIGHT_LINK_VI';
  static String externalCopyrightLinkZhStr = 'EXTERNAL_COPYRIGHT_LINK_ZH';
  static String panelTypeStr = 'PanelType';
  static String panelTypeViStr = 'PanelType_VI';
  static String panelTypeZhStr = 'PanelType_ZH';
  static String askAtOrderEntryStr = 'AskAtOrderEntry';
  static String askAtOrderEntryViStr = 'AskAtOrderEntry_VI';
  static String askAtOrderEntryZhStr = 'AskAtOrderEntry_ZH';
  static String associatedObservationsStr = 'AssociatedObservations';
  static String associatedObservationsViStr = 'AssociatedObservations_VI';
  static String associatedObservationsZhStr = 'AssociatedObservations_ZH';
  static String versionFirstReleasedStr = 'VersionFirstReleased';
  static String versionFirstReleasedViStr = 'VersionFirstReleased_VI';
  static String versionFirstReleasedZhStr = 'VersionFirstReleased_ZH';
  static String validHl7AttachmentRequestStr = 'ValidHL7AttachmentRequest';
  static String validHl7AttachmentRequestViStr = 'ValidHL7AttachmentRequest_VI';
  static String validHl7AttachmentRequestZhStr = 'ValidHL7AttachmentRequest_ZH';
  static String displayNameStr = 'DisplayName';
  static String displayNameViStr = 'DisplayName_VI';
  static String displayNameZhStr = 'DisplayName_ZH';

  static List<String> loincFieldConstants = [
    LoincItemModel.componentStr,
    LoincItemModel.componentViStr,
    LoincItemModel.componentZhStr,
    LoincItemModel.propertyStr,
    LoincItemModel.propertyViStr,
    LoincItemModel.propertyZhStr,
    LoincItemModel.timeAspctStr,
    LoincItemModel.timeAspctViStr,
    LoincItemModel.timeAspctZhStr,
    LoincItemModel.systemStr,
    LoincItemModel.systemViStr,
    LoincItemModel.systemZhStr,
    LoincItemModel.scaleTypStr,
    LoincItemModel.scaleTypViStr,
    LoincItemModel.scaleTypZhStr,
    LoincItemModel.methodTypStr,
    LoincItemModel.methodTypViStr,
    LoincItemModel.methodTypZhStr,
    LoincItemModel.classStr,
    LoincItemModel.classViStr,
    LoincItemModel.classZhStr,
    LoincItemModel.longCommonNameStr,
    LoincItemModel.longCommonNameViStr,
    LoincItemModel.longCommonNameZhStr,
    LoincItemModel.shortNameStr,
    LoincItemModel.shortNameViStr,
    LoincItemModel.shortNameZhStr,
    LoincItemModel.displayNameStr,
    LoincItemModel.displayNameViStr,
    LoincItemModel.displayNameZhStr,
    LoincItemModel.versionLastChangedStr,
    LoincItemModel.versionLastChangedViStr,
    LoincItemModel.versionLastChangedZhStr,
    LoincItemModel.chngTypeStr,
    LoincItemModel.chngTypeViStr,
    LoincItemModel.chngTypeZhStr,
    LoincItemModel.definitionDescriptionStr,
    LoincItemModel.definitionDescriptionViStr,
    LoincItemModel.definitionDescriptionZhStr,
    LoincItemModel.statusStr,
    LoincItemModel.statusViStr,
    LoincItemModel.statusZhStr,
    LoincItemModel.consumerNameStr,
    LoincItemModel.consumerNameViStr,
    LoincItemModel.consumerNameZhStr,
    LoincItemModel.classTypeStr,
    LoincItemModel.classTypeViStr,
    LoincItemModel.classTypeZhStr,
    LoincItemModel.formulaStr,
    LoincItemModel.formulaViStr,
    LoincItemModel.formulaZhStr,
    LoincItemModel.exmplAnswersStr,
    LoincItemModel.exmplAnswersViStr,
    LoincItemModel.exmplAnswersZhStr,
    LoincItemModel.surveyQuestTextStr,
    LoincItemModel.surveyQuestTextViStr,
    LoincItemModel.surveyQuestTextZhStr,
    LoincItemModel.surveyQuestSrcStr,
    LoincItemModel.surveyQuestSrcViStr,
    LoincItemModel.surveyQuestSrcZhStr,
    LoincItemModel.unitsRequiredStr,
    LoincItemModel.unitsRequiredViStr,
    LoincItemModel.unitsRequiredZhStr,
    LoincItemModel.relatedNames2Str,
    LoincItemModel.relatedNames2ViStr,
    LoincItemModel.relatedNames2ZhStr,
    LoincItemModel.orderObsStr,
    LoincItemModel.orderObsViStr,
    LoincItemModel.orderObsZhStr,
    LoincItemModel.hl7FieldSubfieldIdStr,
    LoincItemModel.hl7FieldSubfieldIdViStr,
    LoincItemModel.hl7FieldSubfieldIdZhStr,
    LoincItemModel.externalCopyrightNoticeStr,
    LoincItemModel.externalCopyrightNoticeViStr,
    LoincItemModel.externalCopyrightNoticeZhStr,
    LoincItemModel.exampleUnitsStr,
    LoincItemModel.exampleUnitsViStr,
    LoincItemModel.exampleUnitsZhStr,
    LoincItemModel.exampleUcumUnitsStr,
    LoincItemModel.exampleUcumUnitsViStr,
    LoincItemModel.exampleUcumUnitsZhStr,
    LoincItemModel.statusReasonStr,
    LoincItemModel.statusReasonViStr,
    LoincItemModel.statusReasonZhStr,
    LoincItemModel.statusTextStr,
    LoincItemModel.statusTextViStr,
    LoincItemModel.statusTextZhStr,
    LoincItemModel.changeReasonPublicStr,
    LoincItemModel.changeReasonPublicViStr,
    LoincItemModel.changeReasonPublicZhStr,
    LoincItemModel.commonTestRankStr,
    LoincItemModel.commonTestRankViStr,
    LoincItemModel.commonTestRankZhStr,
    LoincItemModel.commonOrderRankStr,
    LoincItemModel.commonOrderRankViStr,
    LoincItemModel.commonOrderRankZhStr,
    LoincItemModel.hl7AttachmentStructureStr,
    LoincItemModel.hl7AttachmentStructureViStr,
    LoincItemModel.hl7AttachmentStructureZhStr,
    LoincItemModel.externalCopyrightLinkStr,
    LoincItemModel.externalCopyrightLinkViStr,
    LoincItemModel.externalCopyrightLinkZhStr,
    LoincItemModel.panelTypeStr,
    LoincItemModel.panelTypeViStr,
    LoincItemModel.panelTypeZhStr,
    LoincItemModel.askAtOrderEntryStr,
    LoincItemModel.askAtOrderEntryViStr,
    LoincItemModel.askAtOrderEntryZhStr,
    LoincItemModel.associatedObservationsStr,
    LoincItemModel.associatedObservationsViStr,
    LoincItemModel.associatedObservationsZhStr,
    LoincItemModel.versionFirstReleasedStr,
    LoincItemModel.versionFirstReleasedViStr,
    LoincItemModel.versionFirstReleasedZhStr,
    LoincItemModel.validHl7AttachmentRequestStr,
    LoincItemModel.validHl7AttachmentRequestViStr,
    LoincItemModel.validHl7AttachmentRequestZhStr,
    LoincItemModel.loincNumStr, // WHERE condition parameter
  ];

  LoincItemModel({
    this.id = 0,
    this.loincNum = '',
    this.component = '',
    this.componentVi = '',
    this.componentZh = '',
    this.property = '',
    this.propertyVi = '',
    this.propertyZh = '',
    this.timeAspct = '',
    this.timeAspctVi = '',
    this.timeAspctZh = '',
    this.system = '',
    this.systemVi = '',
    this.systemZh = '',
    this.scaleTyp = '',
    this.scaleTypVi = '',
    this.scaleTypZh = '',
    this.methodTyp = '',
    this.methodTypVi = '',
    this.methodTypZh = '',
    this.classField = '',
    this.classVi = '',
    this.classZh = '',
    this.versionLastChanged = '',
    this.versionLastChangedVi = '',
    this.versionLastChangedZh = '',
    this.chngType = '',
    this.chngTypeVi = '',
    this.chngTypeZh = '',
    this.definitionDescription = '',
    this.definitionDescriptionVi = '',
    this.definitionDescriptionZh = '',
    this.status = '',
    this.statusVi = '',
    this.statusZh = '',
    this.consumerName = '',
    this.consumerNameVi = '',
    this.consumerNameZh = '',
    this.classType = '',
    this.classTypeVi = '',
    this.classTypeZh = '',
    this.formula = '',
    this.formulaVi = '',
    this.formulaZh = '',
    this.exmplAnswers = '',
    this.exmplAnswersVi = '',
    this.exmplAnswersZh = '',
    this.surveyQuestText = '',
    this.surveyQuestTextVi = '',
    this.surveyQuestTextZh = '',
    this.surveyQuestSrc = '',
    this.surveyQuestSrcVi = '',
    this.surveyQuestSrcZh = '',
    this.unitsRequired = '',
    this.unitsRequiredVi = '',
    this.unitsRequiredZh = '',
    this.relatedNames2 = '',
    this.relatedNames2Vi = '',
    this.relatedNames2Zh = '',
    this.shortName = '',
    this.shortNameVi = '',
    this.shortNameZh = '',
    this.orderObs = '',
    this.orderObsVi = '',
    this.orderObsZh = '',
    this.hl7FieldSubfieldId = '',
    this.hl7FieldSubfieldIdVi = '',
    this.hl7FieldSubfieldIdZh = '',
    this.externalCopyrightNotice = '',
    this.externalCopyrightNoticeVi = '',
    this.externalCopyrightNoticeZh = '',
    this.exampleUnits = '',
    this.exampleUnitsVi = '',
    this.exampleUnitsZh = '',
    this.longCommonName = '',
    this.longCommonNameVi = '',
    this.longCommonNameZh = '',
    this.exampleUcumUnits = '',
    this.exampleUcumUnitsVi = '',
    this.exampleUcumUnitsZh = '',
    this.statusReason = '',
    this.statusReasonVi = '',
    this.statusReasonZh = '',
    this.statusText = '',
    this.statusTextVi = '',
    this.statusTextZh = '',
    this.changeReasonPublic = '',
    this.changeReasonPublicVi = '',
    this.changeReasonPublicZh = '',
    this.commonTestRank = '',
    this.commonTestRankVi = '',
    this.commonTestRankZh = '',
    this.commonOrderRank = '',
    this.commonOrderRankVi = '',
    this.commonOrderRankZh = '',
    this.hl7AttachmentStructure = '',
    this.hl7AttachmentStructureVi = '',
    this.hl7AttachmentStructureZh = '',
    this.externalCopyrightLink = '',
    this.externalCopyrightLinkVi = '',
    this.externalCopyrightLinkZh = '',
    this.panelType = '',
    this.panelTypeVi = '',
    this.panelTypeZh = '',
    this.askAtOrderEntry = '',
    this.askAtOrderEntryVi = '',
    this.askAtOrderEntryZh = '',
    this.associatedObservations = '',
    this.associatedObservationsVi = '',
    this.associatedObservationsZh = '',
    this.versionFirstReleased = '',
    this.versionFirstReleasedVi = '',
    this.versionFirstReleasedZh = '',
    this.validHl7AttachmentRequest = '',
    this.validHl7AttachmentRequestVi = '',
    this.validHl7AttachmentRequestZh = '',
    this.displayName = '',
    this.displayNameVi = '',
    this.displayNameZh = '',
  });

  // Instance variables for all database fields
  int id;
  String loincNum;
  String component;
  String componentVi;
  String componentZh;
  String property;
  String propertyVi;
  String propertyZh;
  String timeAspct;
  String timeAspctVi;
  String timeAspctZh;
  String system;
  String systemVi;
  String systemZh;
  String scaleTyp;
  String scaleTypVi;
  String scaleTypZh;
  String methodTyp;
  String methodTypVi;
  String methodTypZh;
  String classField; // 'class' is a reserved keyword, so using 'classField'
  String classVi;
  String classZh;
  String versionLastChanged;
  String versionLastChangedVi;
  String versionLastChangedZh;
  String chngType;
  String chngTypeVi;
  String chngTypeZh;
  String definitionDescription;
  String definitionDescriptionVi;
  String definitionDescriptionZh;
  String status;
  String statusVi;
  String statusZh;
  String consumerName;
  String consumerNameVi;
  String consumerNameZh;
  String classType;
  String classTypeVi;
  String classTypeZh;
  String formula;
  String formulaVi;
  String formulaZh;
  String exmplAnswers;
  String exmplAnswersVi;
  String exmplAnswersZh;
  String surveyQuestText;
  String surveyQuestTextVi;
  String surveyQuestTextZh;
  String surveyQuestSrc;
  String surveyQuestSrcVi;
  String surveyQuestSrcZh;
  String unitsRequired;
  String unitsRequiredVi;
  String unitsRequiredZh;
  String relatedNames2;
  String relatedNames2Vi;
  String relatedNames2Zh;
  String shortName;
  String shortNameVi;
  String shortNameZh;
  String orderObs;
  String orderObsVi;
  String orderObsZh;
  String hl7FieldSubfieldId;
  String hl7FieldSubfieldIdVi;
  String hl7FieldSubfieldIdZh;
  String externalCopyrightNotice;
  String externalCopyrightNoticeVi;
  String externalCopyrightNoticeZh;
  String exampleUnits;
  String exampleUnitsVi;
  String exampleUnitsZh;
  String longCommonName;
  String longCommonNameVi;
  String longCommonNameZh;
  String exampleUcumUnits;
  String exampleUcumUnitsVi;
  String exampleUcumUnitsZh;
  String statusReason;
  String statusReasonVi;
  String statusReasonZh;
  String statusText;
  String statusTextVi;
  String statusTextZh;
  String changeReasonPublic;
  String changeReasonPublicVi;
  String changeReasonPublicZh;
  String commonTestRank;
  String commonTestRankVi;
  String commonTestRankZh;
  String commonOrderRank;
  String commonOrderRankVi;
  String commonOrderRankZh;
  String hl7AttachmentStructure;
  String hl7AttachmentStructureVi;
  String hl7AttachmentStructureZh;
  String externalCopyrightLink;
  String externalCopyrightLinkVi;
  String externalCopyrightLinkZh;
  String panelType;
  String panelTypeVi;
  String panelTypeZh;
  String askAtOrderEntry;
  String askAtOrderEntryVi;
  String askAtOrderEntryZh;
  String associatedObservations;
  String associatedObservationsVi;
  String associatedObservationsZh;
  String versionFirstReleased;
  String versionFirstReleasedVi;
  String versionFirstReleasedZh;
  String validHl7AttachmentRequest;
  String validHl7AttachmentRequestVi;
  String validHl7AttachmentRequestZh;
  String displayName;
  String displayNameVi;
  String displayNameZh;

  List<String> getValueList() {
    return [
      component,
      componentVi,
      componentZh,
      property,
      propertyVi,
      propertyZh,
      timeAspct,
      timeAspctVi,
      timeAspctZh,
      system,
      systemVi,
      systemZh,
      scaleTyp,
      scaleTypVi,
      scaleTypZh,
      methodTyp,
      methodTypVi,
      methodTypZh,
      classField,
      classVi,
      classZh,
      longCommonName,
      longCommonNameVi,
      longCommonNameZh,
      shortName,
      shortNameVi,
      shortNameZh,
      displayName,
      displayNameVi,
      displayNameZh,
      versionLastChanged,
      versionLastChangedVi,
      versionLastChangedZh,
      chngType,
      chngTypeVi,
      chngTypeZh,
      definitionDescription,
      definitionDescriptionVi,
      definitionDescriptionZh,
      status,
      statusVi,
      statusZh,
      consumerName,
      consumerNameVi,
      consumerNameZh,
      classType,
      classTypeVi,
      classTypeZh,
      formula,
      formulaVi,
      formulaZh,
      exmplAnswers,
      exmplAnswersVi,
      exmplAnswersZh,
      surveyQuestText,
      surveyQuestTextVi,
      surveyQuestTextZh,
      surveyQuestSrc,
      surveyQuestSrcVi,
      surveyQuestSrcZh,
      unitsRequired,
      unitsRequiredVi,
      unitsRequiredZh,
      relatedNames2,
      relatedNames2Vi,
      relatedNames2Zh,
      orderObs,
      orderObsVi,
      orderObsZh,
      hl7FieldSubfieldId,
      hl7FieldSubfieldIdVi,
      hl7FieldSubfieldIdZh,
      externalCopyrightNotice,
      externalCopyrightNoticeVi,
      externalCopyrightNoticeZh,
      exampleUnits,
      exampleUnitsVi,
      exampleUnitsZh,
      exampleUcumUnits,
      exampleUcumUnitsVi,
      exampleUcumUnitsZh,
      statusReason,
      statusReasonVi,
      statusReasonZh,
      statusText,
      statusTextVi,
      statusTextZh,
      changeReasonPublic,
      changeReasonPublicVi,
      changeReasonPublicZh,
      commonTestRank,
      commonTestRankVi,
      commonTestRankZh,
      commonOrderRank,
      commonOrderRankVi,
      commonOrderRankZh,
      hl7AttachmentStructure,
      hl7AttachmentStructureVi,
      hl7AttachmentStructureZh,
      externalCopyrightLink,
      externalCopyrightLinkVi,
      externalCopyrightLinkZh,
      panelType,
      panelTypeVi,
      panelTypeZh,
      askAtOrderEntry,
      askAtOrderEntryVi,
      askAtOrderEntryZh,
      associatedObservations,
      associatedObservationsVi,
      associatedObservationsZh,
      versionFirstReleased,
      versionFirstReleasedVi,
      versionFirstReleasedZh,
      validHl7AttachmentRequest,
      validHl7AttachmentRequestVi,
      validHl7AttachmentRequestZh,
      loincNum, // WHERE condition parameter
    ];
  }

  // Create instance from Map (useful for database results or JSON parsing)
  static LoincItemModel fromMap(Map<String, dynamic> map) {
    return LoincItemModel(
      id: map[idStr] as int? ?? 0,
      loincNum: map[loincNumStr] as String? ?? '',
      component: map[componentStr] as String? ?? '',
      componentVi: map[componentViStr] as String? ?? '',
      componentZh: map[componentZhStr] as String? ?? '',
      property: map[propertyStr] as String? ?? '',
      propertyVi: map[propertyViStr] as String? ?? '',
      propertyZh: map[propertyZhStr] as String? ?? '',
      timeAspct: map[timeAspctStr] as String? ?? '',
      timeAspctVi: map[timeAspctViStr] as String? ?? '',
      timeAspctZh: map[timeAspctZhStr] as String? ?? '',
      system: map[systemStr] as String? ?? '',
      systemVi: map[systemViStr] as String? ?? '',
      systemZh: map[systemZhStr] as String? ?? '',
      scaleTyp: map[scaleTypStr] as String? ?? '',
      scaleTypVi: map[scaleTypViStr] as String? ?? '',
      scaleTypZh: map[scaleTypZhStr] as String? ?? '',
      methodTyp: map[methodTypStr] as String? ?? '',
      methodTypVi: map[methodTypViStr] as String? ?? '',
      methodTypZh: map[methodTypZhStr] as String? ?? '',
      classField: map[classStr] as String? ?? '',
      classVi: map[classViStr] as String? ?? '',
      classZh: map[classZhStr] as String? ?? '',
      versionLastChanged: map[versionLastChangedStr] as String? ?? '',
      versionLastChangedVi: map[versionLastChangedViStr] as String? ?? '',
      versionLastChangedZh: map[versionLastChangedZhStr] as String? ?? '',
      chngType: map[chngTypeStr] as String? ?? '',
      chngTypeVi: map[chngTypeViStr] as String? ?? '',
      chngTypeZh: map[chngTypeZhStr] as String? ?? '',
      definitionDescription: map[definitionDescriptionStr] as String? ?? '',
      definitionDescriptionVi: map[definitionDescriptionViStr] as String? ?? '',
      definitionDescriptionZh: map[definitionDescriptionZhStr] as String? ?? '',
      status: map[statusStr] as String? ?? '',
      statusVi: map[statusViStr] as String? ?? '',
      statusZh: map[statusZhStr] as String? ?? '',
      consumerName: map[consumerNameStr] as String? ?? '',
      consumerNameVi: map[consumerNameViStr] as String? ?? '',
      consumerNameZh: map[consumerNameZhStr] as String? ?? '',
      classType: map[classTypeStr] as String? ?? '',
      classTypeVi: map[classTypeViStr] as String? ?? '',
      classTypeZh: map[classTypeZhStr] as String? ?? '',
      formula: map[formulaStr] as String? ?? '',
      formulaVi: map[formulaViStr] as String? ?? '',
      formulaZh: map[formulaZhStr] as String? ?? '',
      exmplAnswers: map[exmplAnswersStr] as String? ?? '',
      exmplAnswersVi: map[exmplAnswersViStr] as String? ?? '',
      exmplAnswersZh: map[exmplAnswersZhStr] as String? ?? '',
      surveyQuestText: map[surveyQuestTextStr] as String? ?? '',
      surveyQuestTextVi: map[surveyQuestTextViStr] as String? ?? '',
      surveyQuestTextZh: map[surveyQuestTextZhStr] as String? ?? '',
      surveyQuestSrc: map[surveyQuestSrcStr] as String? ?? '',
      surveyQuestSrcVi: map[surveyQuestSrcViStr] as String? ?? '',
      surveyQuestSrcZh: map[surveyQuestSrcZhStr] as String? ?? '',
      unitsRequired: map[unitsRequiredStr] as String? ?? '',
      unitsRequiredVi: map[unitsRequiredViStr] as String? ?? '',
      unitsRequiredZh: map[unitsRequiredZhStr] as String? ?? '',
      relatedNames2: map[relatedNames2Str] as String? ?? '',
      relatedNames2Vi: map[relatedNames2ViStr] as String? ?? '',
      relatedNames2Zh: map[relatedNames2ZhStr] as String? ?? '',
      shortName: map[shortNameStr] as String? ?? '',
      shortNameVi: map[shortNameViStr] as String? ?? '',
      shortNameZh: map[shortNameZhStr] as String? ?? '',
      orderObs: map[orderObsStr] as String? ?? '',
      orderObsVi: map[orderObsViStr] as String? ?? '',
      orderObsZh: map[orderObsZhStr] as String? ?? '',
      hl7FieldSubfieldId: map[hl7FieldSubfieldIdStr] as String? ?? '',
      hl7FieldSubfieldIdVi: map[hl7FieldSubfieldIdViStr] as String? ?? '',
      hl7FieldSubfieldIdZh: map[hl7FieldSubfieldIdZhStr] as String? ?? '',
      externalCopyrightNotice: map[externalCopyrightNoticeStr] as String? ?? '',
      externalCopyrightNoticeVi: map[externalCopyrightNoticeViStr] as String? ?? '',
      externalCopyrightNoticeZh: map[externalCopyrightNoticeZhStr] as String? ?? '',
      exampleUnits: map[exampleUnitsStr] as String? ?? '',
      exampleUnitsVi: map[exampleUnitsViStr] as String? ?? '',
      exampleUnitsZh: map[exampleUnitsZhStr] as String? ?? '',
      longCommonName: map[longCommonNameStr] as String? ?? '',
      longCommonNameVi: map[longCommonNameViStr] as String? ?? '',
      longCommonNameZh: map[longCommonNameZhStr] as String? ?? '',
      exampleUcumUnits: map[exampleUcumUnitsStr] as String? ?? '',
      exampleUcumUnitsVi: map[exampleUcumUnitsViStr] as String? ?? '',
      exampleUcumUnitsZh: map[exampleUcumUnitsZhStr] as String? ?? '',
      statusReason: map[statusReasonStr] as String? ?? '',
      statusReasonVi: map[statusReasonViStr] as String? ?? '',
      statusReasonZh: map[statusReasonZhStr] as String? ?? '',
      statusText: map[statusTextStr] as String? ?? '',
      statusTextVi: map[statusTextViStr] as String? ?? '',
      statusTextZh: map[statusTextZhStr] as String? ?? '',
      changeReasonPublic: map[changeReasonPublicStr] as String? ?? '',
      changeReasonPublicVi: map[changeReasonPublicViStr] as String? ?? '',
      changeReasonPublicZh: map[changeReasonPublicZhStr] as String? ?? '',
      commonTestRank: map[commonTestRankStr] as String? ?? '',
      commonTestRankVi: map[commonTestRankViStr] as String? ?? '',
      commonTestRankZh: map[commonTestRankZhStr] as String? ?? '',
      commonOrderRank: map[commonOrderRankStr] as String? ?? '',
      commonOrderRankVi: map[commonOrderRankViStr] as String? ?? '',
      commonOrderRankZh: map[commonOrderRankZhStr] as String? ?? '',
      hl7AttachmentStructure: map[hl7AttachmentStructureStr] as String? ?? '',
      hl7AttachmentStructureVi: map[hl7AttachmentStructureViStr] as String? ?? '',
      hl7AttachmentStructureZh: map[hl7AttachmentStructureZhStr] as String? ?? '',
      externalCopyrightLink: map[externalCopyrightLinkStr] as String? ?? '',
      externalCopyrightLinkVi: map[externalCopyrightLinkViStr] as String? ?? '',
      externalCopyrightLinkZh: map[externalCopyrightLinkZhStr] as String? ?? '',
      panelType: map[panelTypeStr] as String? ?? '',
      panelTypeVi: map[panelTypeViStr] as String? ?? '',
      panelTypeZh: map[panelTypeZhStr] as String? ?? '',
      askAtOrderEntry: map[askAtOrderEntryStr] as String? ?? '',
      askAtOrderEntryVi: map[askAtOrderEntryViStr] as String? ?? '',
      askAtOrderEntryZh: map[askAtOrderEntryZhStr] as String? ?? '',
      associatedObservations: map[associatedObservationsStr] as String? ?? '',
      associatedObservationsVi: map[associatedObservationsViStr] as String? ?? '',
      associatedObservationsZh: map[associatedObservationsZhStr] as String? ?? '',
      versionFirstReleased: map[versionFirstReleasedStr] as String? ?? '',
      versionFirstReleasedVi: map[versionFirstReleasedViStr] as String? ?? '',
      versionFirstReleasedZh: map[versionFirstReleasedZhStr] as String? ?? '',
      validHl7AttachmentRequest: map[validHl7AttachmentRequestStr] as String? ?? '',
      validHl7AttachmentRequestVi: map[validHl7AttachmentRequestViStr] as String? ?? '',
      validHl7AttachmentRequestZh: map[validHl7AttachmentRequestZhStr] as String? ?? '',
      displayName: map[displayNameStr] as String? ?? '',
      displayNameVi: map[displayNameViStr] as String? ?? '',
      displayNameZh: map[displayNameZhStr] as String? ?? '',
    );
  }

  // JSON serialization method
  Map<String, dynamic> toJson() {
    return {
      idStr: id,
      loincNumStr: loincNum,
      componentStr: component,
      componentViStr: componentVi,
      componentZhStr: componentZh,
      propertyStr: property,
      propertyViStr: propertyVi,
      propertyZhStr: propertyZh,
      timeAspctStr: timeAspct,
      timeAspctViStr: timeAspctVi,
      timeAspctZhStr: timeAspctZh,
      systemStr: system,
      systemViStr: systemVi,
      systemZhStr: systemZh,
      scaleTypStr: scaleTyp,
      scaleTypViStr: scaleTypVi,
      scaleTypZhStr: scaleTypZh,
      methodTypStr: methodTyp,
      methodTypViStr: methodTypVi,
      methodTypZhStr: methodTypZh,
      classStr: classField,
      classViStr: classVi,
      classZhStr: classZh,
      versionLastChangedStr: versionLastChanged,
      versionLastChangedViStr: versionLastChangedVi,
      versionLastChangedZhStr: versionLastChangedZh,
      chngTypeStr: chngType,
      chngTypeViStr: chngTypeVi,
      chngTypeZhStr: chngTypeZh,
      definitionDescriptionStr: definitionDescription,
      definitionDescriptionViStr: definitionDescriptionVi,
      definitionDescriptionZhStr: definitionDescriptionZh,
      statusStr: status,
      statusViStr: statusVi,
      statusZhStr: statusZh,
      consumerNameStr: consumerName,
      consumerNameViStr: consumerNameVi,
      consumerNameZhStr: consumerNameZh,
      classTypeStr: classType,
      classTypeViStr: classTypeVi,
      classTypeZhStr: classTypeZh,
      formulaStr: formula,
      formulaViStr: formulaVi,
      formulaZhStr: formulaZh,
      exmplAnswersStr: exmplAnswers,
      exmplAnswersViStr: exmplAnswersVi,
      exmplAnswersZhStr: exmplAnswersZh,
      surveyQuestTextStr: surveyQuestText,
      surveyQuestTextViStr: surveyQuestTextVi,
      surveyQuestTextZhStr: surveyQuestTextZh,
      surveyQuestSrcStr: surveyQuestSrc,
      surveyQuestSrcViStr: surveyQuestSrcVi,
      surveyQuestSrcZhStr: surveyQuestSrcZh,
      unitsRequiredStr: unitsRequired,
      unitsRequiredViStr: unitsRequiredVi,
      unitsRequiredZhStr: unitsRequiredZh,
      relatedNames2Str: relatedNames2,
      relatedNames2ViStr: relatedNames2Vi,
      relatedNames2ZhStr: relatedNames2Zh,
      shortNameStr: shortName,
      shortNameViStr: shortNameVi,
      shortNameZhStr: shortNameZh,
      orderObsStr: orderObs,
      orderObsViStr: orderObsVi,
      orderObsZhStr: orderObsZh,
      hl7FieldSubfieldIdStr: hl7FieldSubfieldId,
      hl7FieldSubfieldIdViStr: hl7FieldSubfieldIdVi,
      hl7FieldSubfieldIdZhStr: hl7FieldSubfieldIdZh,
      externalCopyrightNoticeStr: externalCopyrightNotice,
      externalCopyrightNoticeViStr: externalCopyrightNoticeVi,
      externalCopyrightNoticeZhStr: externalCopyrightNoticeZh,
      exampleUnitsStr: exampleUnits,
      exampleUnitsViStr: exampleUnitsVi,
      exampleUnitsZhStr: exampleUnitsZh,
      longCommonNameStr: longCommonName,
      longCommonNameViStr: longCommonNameVi,
      longCommonNameZhStr: longCommonNameZh,
      exampleUcumUnitsStr: exampleUcumUnits,
      exampleUcumUnitsViStr: exampleUcumUnitsVi,
      exampleUcumUnitsZhStr: exampleUcumUnitsZh,
      statusReasonStr: statusReason,
      statusReasonViStr: statusReasonVi,
      statusReasonZhStr: statusReasonZh,
      statusTextStr: statusText,
      statusTextViStr: statusTextVi,
      statusTextZhStr: statusTextZh,
      changeReasonPublicStr: changeReasonPublic,
      changeReasonPublicViStr: changeReasonPublicVi,
      changeReasonPublicZhStr: changeReasonPublicZh,
      commonTestRankStr: commonTestRank,
      commonTestRankViStr: commonTestRankVi,
      commonTestRankZhStr: commonTestRankZh,
      commonOrderRankStr: commonOrderRank,
      commonOrderRankViStr: commonOrderRankVi,
      commonOrderRankZhStr: commonOrderRankZh,
      hl7AttachmentStructureStr: hl7AttachmentStructure,
      hl7AttachmentStructureViStr: hl7AttachmentStructureVi,
      hl7AttachmentStructureZhStr: hl7AttachmentStructureZh,
      externalCopyrightLinkStr: externalCopyrightLink,
      externalCopyrightLinkViStr: externalCopyrightLinkVi,
      externalCopyrightLinkZhStr: externalCopyrightLinkZh,
      panelTypeStr: panelType,
      panelTypeViStr: panelTypeVi,
      panelTypeZhStr: panelTypeZh,
      askAtOrderEntryStr: askAtOrderEntry,
      askAtOrderEntryViStr: askAtOrderEntryVi,
      askAtOrderEntryZhStr: askAtOrderEntryZh,
      associatedObservationsStr: associatedObservations,
      associatedObservationsViStr: associatedObservationsVi,
      associatedObservationsZhStr: associatedObservationsZh,
      versionFirstReleasedStr: versionFirstReleased,
      versionFirstReleasedViStr: versionFirstReleasedVi,
      versionFirstReleasedZhStr: versionFirstReleasedZh,
      validHl7AttachmentRequestStr: validHl7AttachmentRequest,
      validHl7AttachmentRequestViStr: validHl7AttachmentRequestVi,
      validHl7AttachmentRequestZhStr: validHl7AttachmentRequestZh,
      displayNameStr: displayName,
      displayNameViStr: displayNameVi,
      displayNameZhStr: displayNameZh,
    };
  }
}
