class Icd10PcsItemModel {
  // Static field name constants
  static String idStr = 'id';
  static String codeStr = 'code';
  static String descriptionEnStr = 'description_en';
  static String descriptionViStr = 'description_vi';
  static String descriptionZhStr = 'description_zh';

  static List<String> icd10pcsFieldConstants = [
    Icd10PcsItemModel.codeStr,
    Icd10PcsItemModel.descriptionEnStr,
    Icd10PcsItemModel.descriptionViStr,
    Icd10PcsItemModel.descriptionZhStr,
  ];

  Icd10PcsItemModel({this.id = 0, this.code = '', this.descriptionEn = '', this.descriptionVi = '', this.descriptionZh = ''});

  // Instance variables for all database fields
  int id;
  String code;
  String descriptionEn;
  String descriptionVi;
  String descriptionZh;

  List<String> getValueList() {
    return [descriptionEn, descriptionVi, descriptionZh, code];
  }

  // Create instance from Map (useful for database results or JSON parsing)
  static Icd10PcsItemModel fromMap(Map<String, dynamic> map) {
    return Icd10PcsItemModel(
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
