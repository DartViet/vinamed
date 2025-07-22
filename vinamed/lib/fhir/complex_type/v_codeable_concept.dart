import 'package:ltdmed/fhir/complex_type/v_coding.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VCodeableConcept {
  List<VCoding> coding;
  Vstring text;

  VCodeableConcept({required this.coding, required this.text});

  Map<String, dynamic> toJson() {
    return {'coding': coding.map((c) => c.toJson()).toList(), 'text': text};
  }

  factory VCodeableConcept.fromJson(Map<String, dynamic> json) {
    return VCodeableConcept(coding: (json['coding'] as List).map((c) => VCoding.fromJson(c as Map<String, dynamic>)).toList(), text: json['text'] as String);
  }
}
