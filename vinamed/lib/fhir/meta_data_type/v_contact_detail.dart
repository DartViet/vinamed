import 'package:ltdmed/fhir/data_type/v_contact_point.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VContactDetail {
  Vstring? name; // Name of the contact person
  List<VContactPoint>? telecom; // Contact points for the contact person

  VContactDetail({this.name, this.telecom});

  Map<String, dynamic> toJson() {
    return {'name': name, 'telecom': telecom?.map((t) => t.toJson()).toList()}..removeWhere((key, value) => value == null);
  }

  factory VContactDetail.fromJson(Map<String, dynamic> json) {
    return VContactDetail(name: json['name'], telecom: (json['telecom'] as List?)?.map((e) => VContactPoint.fromJson(e as Map<String, dynamic>)).toList());
  }
}
