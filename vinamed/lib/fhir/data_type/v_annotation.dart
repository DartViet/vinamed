import 'package:ltdmed/fhir/primitive.dart';
import 'package:ltdmed/fhir/v_reference.dart';

class VAnnotation {
  VReference? authorReference; // Reference to the author of the annotation (Organization|Patient|Practitioner|PractitionerRole|RelatedPerson)
  Vstring? authorString; // Name of the author of the annotation
  VdateTime? time; // Time when the annotation was created
  Vmarkdown? text; // The content of the annotation, typically in markdown format

  VAnnotation({this.authorReference, this.authorString, this.time, this.text});

  Map<String, dynamic> toJson() {
    return {'authorReference': authorReference?.toJson(), 'authorString': authorString, 'time': time, 'text': text}..removeWhere((key, value) => value == null);
  }

  factory VAnnotation.fromJson(Map<String, dynamic> json) {
    return VAnnotation(
      authorReference: json['authorReference'] != null ? VReference.fromJson(json['authorReference']) : null,
      authorString: json['authorString'],
      time: json['time'],
      text: json['text'],
    );
  }
}
