import 'dart:convert';

import 'package:database_models/models/codes_data_models/dhs_model.dart';
import 'package:database_models/models/codes_data_models/fda_drug_model.dart';
import 'package:database_models/models/codes_data_models/icd10cm_model.dart';
import 'package:database_models/models/codes_data_models/icd10pcs_model.dart';
import 'package:database_models/models/codes_data_models/loinc_model.dart';
import 'package:http/http.dart' as http;
import 'package:database_models/models/variables/variables.dart';

class CodeSearchService {
  // Private constructor
  CodeSearchService._internal();

  // Static instance
  static final CodeSearchService _instance = CodeSearchService._internal();

  // Factory constructor that returns the same instance
  factory CodeSearchService() => _instance;

  // Getter for the instance
  static CodeSearchService get instance => _instance;

  Future<List<Object>> searchCodes(String query, String code) async {
    try {
      if (query.isEmpty) {
        return [];
      }
      final response = await http.post(
        Uri.parse('${Variables.instance.darServerUrl}/$code/search'),
        headers: {'Content-Type': 'application/json'},
        body: query.trim(),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Object> results = parseSearchResults(data, code);
        return results;
      } else {
        throw Exception('Failed to load codes');
      }
    } catch (e) {
      print('Error searching codes: $e');
      return [];
    }
  }

  List<Object> parseSearchResults(List<dynamic> items, String code) {
    List<Object> results = [];

    for (var item in items) {
      if (item is Map<String, dynamic>) {
        if (code == Variables.instance.icd10cm) {
          Icd10CmItemModel icd10CmItem = Icd10CmItemModel.fromMap(item);
          results.add(icd10CmItem);
        } else if (code == Variables.instance.icd10pcs) {
          Icd10PcsItemModel icd10PcsItem = Icd10PcsItemModel.fromMap(item);
          results.add(icd10PcsItem);
        } else if (code == Variables.instance.fdadrug) {
          FdaDrugModel fdaDrugItem = FdaDrugModel.fromMap(item);
          results.add(fdaDrugItem);
        } else if (code == Variables.instance.loinc) {
          LoincItemModel loincItem = LoincItemModel.fromMap(item);
          results.add(loincItem);
        } else if (code == Variables.instance.dhs) {
          DhsModel dhsItem = DhsModel.fromMap(item);
          results.add(dhsItem);
        }
      }
    }
    return results;
  }
}
