import 'package:ltdmed/fhir/primitive.dart';

class VPeriod {
  VdateTime start;
  VdateTime end;

  VPeriod({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    return {'start': start, 'end': end};
  }

  factory VPeriod.fromJson(Map<String, dynamic> json) {
    return VPeriod(start: json['start'], end: json['end']);
  }
}
