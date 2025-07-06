class Variables {
  static Variables? _instance;

  Variables._internal();

  static Variables get instance {
    _instance ??= Variables._internal();
    return _instance!;
  }

  String icd10cmFile = 'icd10cm.txt';
  String icd10pcsFile = 'icd10pcs.txt';
  String dhsFile = 'dhs.txt';
  String cptFolder = 'cpt';
  String lonicFile = 'Loinc.csv';
  String fdaDrugFile = 'fda_drug.txt';

  String icd10cmTable = 'ICD10_CM';
  String icd10pcsTable = 'ICD10_PCS';
  String dhsTable = 'DHS';
  String lonicTable = 'LOINC';
  String fdaDrugTable = 'FDA_DRUG';
}
