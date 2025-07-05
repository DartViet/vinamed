class FdaDrugModel {
  // Static field name constants
  static String idStr = 'id';
  static String applNoStr = 'ApplNo';
  static String productNoStr = 'ProductNo';
  static String productNoViStr = 'ProductNo_VI';
  static String productNoZhStr = 'ProductNo_ZH';
  static String formStr = 'Form';
  static String formViStr = 'Form_VI';
  static String formZhStr = 'Form_ZH';
  static String strengthStr = 'Strength';
  static String strengthViStr = 'Strength_VI';
  static String strengthZhStr = 'Strength_ZH';
  static String referenceDrugStr = 'ReferenceDrug';
  static String referenceDrugViStr = 'ReferenceDrug_VI';
  static String referenceDrugZhStr = 'ReferenceDrug_ZH';
  static String drugNameStr = 'DrugName';
  static String drugNameViStr = 'DrugName_VI';
  static String drugNameZhStr = 'DrugName_ZH';
  static String activeIngredientStr = 'ActiveIngredient';
  static String activeIngredientViStr = 'ActiveIngredient_VI';
  static String activeIngredientZhStr = 'ActiveIngredient_ZH';
  static String referenceStandardStr = 'ReferenceStandard';
  static String referenceStandardViStr = 'ReferenceStandard_VI';
  static String referenceStandardZhStr = 'ReferenceStandard_ZH';

  static List<String> fdaDrugFieldConstants = [
    FdaDrugModel.productNoStr,
    FdaDrugModel.productNoViStr,
    FdaDrugModel.productNoZhStr,
    FdaDrugModel.formStr,
    FdaDrugModel.formViStr,
    FdaDrugModel.formZhStr,
    FdaDrugModel.strengthStr,
    FdaDrugModel.strengthViStr,
    FdaDrugModel.strengthZhStr,
    FdaDrugModel.referenceDrugStr,
    FdaDrugModel.referenceDrugViStr,
    FdaDrugModel.referenceDrugZhStr,
    FdaDrugModel.drugNameStr,
    FdaDrugModel.drugNameViStr,
    FdaDrugModel.drugNameZhStr,
    FdaDrugModel.activeIngredientStr,
    FdaDrugModel.activeIngredientViStr,
    FdaDrugModel.activeIngredientZhStr,
    FdaDrugModel.referenceStandardStr,
    FdaDrugModel.referenceStandardViStr,
    FdaDrugModel.referenceStandardZhStr,
    FdaDrugModel.applNoStr, // WHERE condition parameter
  ];

  FdaDrugModel({
    this.id = 0,
    this.applNo = '',
    this.productNo = '',
    this.productNoVi = '',
    this.productNoZh = '',
    this.form = '',
    this.formVi = '',
    this.formZh = '',
    this.strength = '',
    this.strengthVi = '',
    this.strengthZh = '',
    this.referenceDrug = '',
    this.referenceDrugVi = '',
    this.referenceDrugZh = '',
    this.drugName = '',
    this.drugNameVi = '',
    this.drugNameZh = '',
    this.activeIngredient = '',
    this.activeIngredientVi = '',
    this.activeIngredientZh = '',
    this.referenceStandard = '',
    this.referenceStandardVi = '',
    this.referenceStandardZh = '',
  });

  // Instance variables for all database fields
  int id;
  String applNo;
  String productNo;
  String productNoVi;
  String productNoZh;
  String form;
  String formVi;
  String formZh;
  String strength;
  String strengthVi;
  String strengthZh;
  String referenceDrug;
  String referenceDrugVi;
  String referenceDrugZh;
  String drugName;
  String drugNameVi;
  String drugNameZh;
  String activeIngredient;
  String activeIngredientVi;
  String activeIngredientZh;
  String referenceStandard;
  String referenceStandardVi;
  String referenceStandardZh;

  List<String> getValueList() {
    return [
      productNo,
      productNoVi,
      productNoZh,
      form,
      formVi,
      formZh,
      strength,
      strengthVi,
      strengthZh,
      referenceDrug,
      referenceDrugVi,
      referenceDrugZh,
      drugName,
      drugNameVi,
      drugNameZh,
      activeIngredient,
      activeIngredientVi,
      activeIngredientZh,
      referenceStandard,
      referenceStandardVi,
      referenceStandardZh,
      applNo, // WHERE condition parameter
    ];
  }

  // Create instance from Map (useful for database results or JSON parsing)
  static FdaDrugModel fromMap(Map<String, dynamic> map) {
    return FdaDrugModel(
      id: map[idStr] as int? ?? 0,
      applNo: map[applNoStr] as String? ?? '',
      productNo: map[productNoStr] as String? ?? '',
      productNoVi: map[productNoViStr] as String? ?? '',
      productNoZh: map[productNoZhStr] as String? ?? '',
      form: map[formStr] as String? ?? '',
      formVi: map[formViStr] as String? ?? '',
      formZh: map[formZhStr] as String? ?? '',
      strength: map[strengthStr] as String? ?? '',
      strengthVi: map[strengthViStr] as String? ?? '',
      strengthZh: map[strengthZhStr] as String? ?? '',
      referenceDrug: map[referenceDrugStr] as String? ?? '',
      referenceDrugVi: map[referenceDrugViStr] as String? ?? '',
      referenceDrugZh: map[referenceDrugZhStr] as String? ?? '',
      drugName: map[drugNameStr] as String? ?? '',
      drugNameVi: map[drugNameViStr] as String? ?? '',
      drugNameZh: map[drugNameZhStr] as String? ?? '',
      activeIngredient: map[activeIngredientStr] as String? ?? '',
      activeIngredientVi: map[activeIngredientViStr] as String? ?? '',
      activeIngredientZh: map[activeIngredientZhStr] as String? ?? '',
      referenceStandard: map[referenceStandardStr] as String? ?? '',
      referenceStandardVi: map[referenceStandardViStr] as String? ?? '',
      referenceStandardZh: map[referenceStandardZhStr] as String? ?? '',
    );
  }

  // JSON serialization method
  Map<String, dynamic> toJson() {
    return {
      idStr: id,
      applNoStr: applNo,
      productNoStr: productNo,
      productNoViStr: productNoVi,
      productNoZhStr: productNoZh,
      formStr: form,
      formViStr: formVi,
      formZhStr: formZh,
      strengthStr: strength,
      strengthViStr: strengthVi,
      strengthZhStr: strengthZh,
      referenceDrugStr: referenceDrug,
      referenceDrugViStr: referenceDrugVi,
      referenceDrugZhStr: referenceDrugZh,
      drugNameStr: drugName,
      drugNameViStr: drugNameVi,
      drugNameZhStr: drugNameZh,
      activeIngredientStr: activeIngredient,
      activeIngredientViStr: activeIngredientVi,
      activeIngredientZhStr: activeIngredientZh,
      referenceStandardStr: referenceStandard,
      referenceStandardViStr: referenceStandardVi,
      referenceStandardZhStr: referenceStandardZh,
    };
  }
}
