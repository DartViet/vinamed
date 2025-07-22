import 'package:fhir_reader/src/value_sets/vs_resource.dart';

class VsEntry {
  String? fullUrl;
  List<VsResource>? resource;

  VsEntry({this.fullUrl, this.resource});

  factory VsEntry.fromJson(Map<String, dynamic> json) {
    return VsEntry(
      fullUrl: json['fullUrl'],
      resource: (json['resource'] as List<dynamic>?)
          ?.map((item) => VsResource.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'fullUrl': fullUrl, 'resource': resource?.map((item) => item.toJson()).toList()}
      ..removeWhere((key, value) => value == null);
  }
}
