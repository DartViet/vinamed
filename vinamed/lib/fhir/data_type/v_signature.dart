import 'package:ltdmed/fhir/primitive.dart';
import 'package:ltdmed/fhir/v_reference.dart';

class VSignature {
  List<Vstring>? type; // Type of signature (e.g., digital, handwritten)
  Vinstant? when; // Time when the signature was created
  VReference? who; // Reference to the person or entity who signed --> Device|Organization|Patient|Practitioner|PractitionerRole|RelatedPerson
  VReference?
  onBehalfOf; // Reference to the organization on behalf of which the signature is signed -->Device|Organization|Patient|Practitioner|PractitionerRole|RelatedPerson
  VCode? targetFormat; // Format of the signed content (e.g., PDF, XML)
  VCode? sigFormat; // Format of the signature (e.g., X.509, PGP)
  Vbase64Binary? data; // The actual signature data, typically in base64 encoding

  VSignature({this.type, this.when, this.who, this.onBehalfOf, this.targetFormat, this.sigFormat, this.data});

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'when': when,
      'who': who?.toJson(),
      'onBehalfOf': onBehalfOf?.toJson(),
      'targetFormat': targetFormat,
      'sigFormat': sigFormat,
      'data': data,
    }..removeWhere((key, value) => value == null);
  }

  factory VSignature.fromJson(Map<String, dynamic> json) {
    return VSignature(
      type: (json['type'] as List?)?.map((e) => e.toString()).toList(),
      when: json['when'],
      who: json['who'] != null ? VReference.fromJson(json['who']) : null,
      onBehalfOf: json['onBehalfOf'] != null ? VReference.fromJson(json['onBehalfOf']) : null,
      targetFormat: json['targetFormat'],
      sigFormat: json['sigFormat'],
      data: json['data'],
    );
  }
}
