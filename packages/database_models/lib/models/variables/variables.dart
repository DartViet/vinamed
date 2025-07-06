class Variables {
  // Private constructor
  Variables._internal() {
    codes = [icd10cm, icd10pcs, fdadrug, loinc, dhs];
    codeNames = [icd10cmName, icd10pcsName, fdadrugName, loincName, dhsName];
    codeToName = {icd10cm: icd10cmName, icd10pcs: icd10pcsName, fdadrug: fdadrugName, loinc: loincName, dhs: dhsName};
  }

  // Static instance
  static final Variables _instance = Variables._internal();

  // Factory constructor that returns the same instance
  factory Variables() => _instance;

  // Getter for the instance
  static Variables get instance => _instance;

  // code variables
  final String icd10cm = "icd10cm";
  final String icd10pcs = "icd10pcs";
  final String fdadrug = "fdadrug";
  final String loinc = "loinc";
  final String dhs = "dhs";

  // code names
  final String icd10cmName = "ICD-10-CM";
  final String icd10pcsName = "ICD-10-PCS";
  final String fdadrugName = "FDA Drug";
  final String loincName = "LOINC";
  final String dhsName = "DHS";

  List<String> codes = [];
  List<String> codeNames = [];
  Map<String, String> codeToName = {};

  String darServerUrl = "https://ltd.zapto.org/webserver/api/v1";

  // Add other variables as needed
}
