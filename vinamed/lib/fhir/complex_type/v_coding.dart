import 'package:ltdmed/fhir/primitive.dart';

class VCoding {
  final Vuri system;
  final Vstring version;
  final VCode code;
  final Vstring display;
  final Vboolean userSelected;

  VCoding({required this.system, required this.version, required this.code, required this.display, required this.userSelected});

  factory VCoding.fromJson(Map<String, dynamic> json) {
    return VCoding(
      system: json['system'] ?? '',
      version: json['version'] ?? '',
      code: json['code'] ?? '',
      display: json['display'] ?? '',
      userSelected: json['userSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'version': version, 'code': code, 'display': display, 'userSelected': userSelected};
  }
}
