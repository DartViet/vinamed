import 'package:ltdmed/fhir/data_type/v_identifier.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VReference<T> {
  Vstring? reference;
  Vuri? type; //
  VIdentifier? identifier; // Identifier for the reference
  Vstring? display; // Display text for the reference
  T? resource; // The actual resource, if applicable

  VReference({this.reference, this.type, this.identifier, this.display, this.resource});

  // Don't put the resource in toJson, as it may not be serializable or may not be needed
  Map<String, dynamic> toJson() {
    return {'reference': reference, 'type': type, 'identifier': identifier?.toJson(), 'display': display};
  }

  // Don't put the resource in fromJson, as it may not be serializable or may not be needed
  factory VReference.fromJson(Map<String, dynamic> json) {
    return VReference(
      reference: json['reference'],
      type: json['type'],
      identifier: json['identifier'] != null ? VIdentifier.fromJson(json['identifier']) : null,
      display: json['display'],
    );
  }
}
