import 'package:ltdmed/fhir/complex_type/v_attachment.dart';
import 'package:ltdmed/fhir/complex_type/v_codeable_concept.dart';
import 'package:ltdmed/fhir/primitive.dart';
import 'package:ltdmed/fhir/v_reference.dart';

class VRelatedArtifact {
  VCode? type; // Type of the related artifact
  VCodeableConcept? typeCodeableConcept; // Type as a codeable concept
  Vstring? label; // Label for the related artifact
  Vstring? display; // Display text for the related artifact
  Vstring? citation; // Citation for the related artifact
  VAttachment? document; // Document related to the artifact
  VCanonical? resource; // Reference to a resource related to the artifact
  VReference? resourceReference; // Reference to a resource related to the artifact
  VCode? publicationStatus; // Publication status of the related artifact
  Vdate? publicationDate; // Publication date of the related artifact

  VRelatedArtifact({
    this.type,
    this.typeCodeableConcept,
    this.label,
    this.display,
    this.citation,
    this.document,
    this.resource,
    this.resourceReference,
    this.publicationStatus,
    this.publicationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'typeCodeableConcept': typeCodeableConcept?.toJson(),
      'label': label,
      'display': display,
      'citation': citation,
      'document': document?.toJson(),
      'resource': resource,
      'resourceReference': resourceReference?.toJson(),
      'publicationStatus': publicationStatus,
      'publicationDate': publicationDate,
    }..removeWhere((key, value) => value == null);
  }

  factory VRelatedArtifact.fromJson(Map<String, dynamic> json) {
    return VRelatedArtifact(
      type: json['type'],
      typeCodeableConcept: json['typeCodeableConcept'] != null ? VCodeableConcept.fromJson(json['typeCodeableConcept']) : null,
      label: json['label'],
      display: json['display'],
      citation: json['citation'],
      document: json['document'] != null ? VAttachment.fromJson(json['document']) : null,
      resource: json['resource'],
      resourceReference: json['resourceReference'] != null ? VReference.fromJson(json['resourceReference']) : null,
      publicationStatus: json['publicationStatus'],
      publicationDate: json['publicationDate'],
    );
  }
}
