import 'package:ltdmed/fhir/complex_type/v_codeable_concept.dart';
import 'package:ltdmed/fhir/data_type/v_timing/v_repeat.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VTiming {
  List<VdateTime>? event; // Specific times when the event occurs
  VRepeat? repeat; // Repeat information for the timing
  VCodeableConcept? code; // C | BID | TID | QID | AM | PM | QD | QOD | Q1H Check fhir_files/code_system.dart for more codes

  VTiming({this.event, this.repeat, this.code});

  Map<String, dynamic> toJson() {
    return {'event': event?.map((e) => e.toString()).toList(), 'repeat': repeat?.toJson(), 'code': code?.toJson()}..removeWhere((key, value) => value == null);
  }

  factory VTiming.fromJson(Map<String, dynamic> json) {
    return VTiming(
      event: (json['event'] as List?)?.map((e) => e as VdateTime).toList(),
      repeat: json['repeat'] != null ? VRepeat.fromJson(json['repeat']) : null,
      code: json['code'] != null ? VCodeableConcept.fromJson(json['code']) : null,
    );
  }
}
