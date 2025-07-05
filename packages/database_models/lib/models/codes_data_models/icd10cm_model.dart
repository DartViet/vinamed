class Icd10CmItemModel {
  // Static field name constants
  static String idStr = 'id';
  static String codeStr = 'code';
  static String descriptionEnStr = 'description_en';
  static String descriptionViStr = 'description_vi';
  static String descriptionZhStr = 'description_zh';

  static List<String> icd10cmFieldConstants = [
    Icd10CmItemModel.codeStr,
    Icd10CmItemModel.descriptionEnStr,
    Icd10CmItemModel.descriptionViStr,
    Icd10CmItemModel.descriptionZhStr,
  ];

  Icd10CmItemModel({this.id = 0, this.code = '', this.descriptionEn = '', this.descriptionVi = '', this.descriptionZh = ''});

  // Instance variables for all database fields
  int id;
  String code;
  String descriptionEn;
  String descriptionVi;
  String descriptionZh;

  List<String> getValueList() {
    // code for Where clause, put it last
    return [descriptionEn, descriptionVi, descriptionZh, code];
  }

  // Create instance from Map (useful for database results or JSON parsing)
  static Icd10CmItemModel fromMap(Map<String, dynamic> map) {
    return Icd10CmItemModel(
      id: map[idStr] as int? ?? 0,
      code: map[codeStr] as String? ?? '',
      descriptionEn: map[descriptionEnStr] as String? ?? '',
      descriptionVi: map[descriptionViStr] as String? ?? '',
      descriptionZh: map[descriptionZhStr] as String? ?? '',
    );
  }

  // JSON serialization method
  Map<String, dynamic> toJson() {
    return {idStr: id, codeStr: code, descriptionEnStr: descriptionEn, descriptionViStr: descriptionVi, descriptionZhStr: descriptionZh};
  }
}
