import 'package:ltdmed/fhir/complex_type/v_codeable_concept.dart';
import 'package:ltdmed/fhir/complex_type/v_organization.dart';
import 'package:ltdmed/fhir/data_type/v_period.dart';
import 'package:ltdmed/fhir/primitive.dart';
import 'package:ltdmed/fhir/v_reference.dart';

class VIdentifier {
  Vstring? use; // usual | official | temp | secondary - purpose of this identifier
  VCodeableConcept? type; // Type of identifier, e.g., MRN, SSN
  Vuri? system; // The namespace for the identifier value
  Vstring? value; // The actual identifier value
  VPeriod? period; // Time period during which the identifier is valid
  VReference<VOrganization>? assigner; // Organization that issued the identifier

  VIdentifier({this.use, this.type, this.system, this.value, this.period, this.assigner});

  Map<String, dynamic> toJson() {
    return {'use': use, 'type': type?.toJson(), 'system': system, 'value': value, 'period': period?.toJson(), 'assigner': assigner?.toJson()};
  }

  factory VIdentifier.fromJson(Map<String, dynamic> json) {
    return VIdentifier(
      use: json['use'],
      type: json['type'] != null ? VCodeableConcept.fromJson(json['type']) : null,
      system: json['system'],
      value: json['value'],
      period: json['period'] != null ? VPeriod.fromJson(json['period']) : null,
      assigner: json['assigner'] != null ? VReference.fromJson(json['assigner']) : null,
    );
  }
}
