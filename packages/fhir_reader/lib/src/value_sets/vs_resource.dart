import 'package:fhir_reader/src/value_sets/vs_contact_item.dart';
import 'package:fhir_reader/src/value_sets/vs_extension_item.dart';
import 'package:fhir_reader/src/value_sets/vs_filter_item.dart';
import 'package:fhir_reader/src/value_sets/vs_jurisdiction_item.dart';
import 'package:fhir_reader/src/value_sets/vs_meta.dart';
import 'package:fhir_reader/src/value_sets/vs_text.dart';
import 'package:fhir_reader/src/value_sets/vs_use_context.dart';

class VsResource {
  String? resourceType;
  String? id;
  VsMeta? meta;
  VsText? text;
  List<VSExtensionItem>? extension;
  String? url;
  List<VSFilterItem>? identifier;
  String? version;
  String? name;
  String? title;
  String? status;
  bool? experimental;
  String? date;
  String? publisher;
  List<VSContactItem>? contact;
  String? description;
  bool? caseSensitive;
  String? content;
  String? valueSet;
  String? hierarchyMeaning;
  String? purpose;
  String? copyright;
  List<VSFilterItem>? property;
  List<VSContactItem>? concept;
  bool? immutable;
  List<VsJurisdictionItem>? jurisdiction;
  List<VsUseContext>? useContext;

  VsResource({
    this.resourceType,
    this.id,
    this.meta,
    this.text,
    this.extension,
    this.url,
    this.identifier,
    this.version,
    this.name,
    this.title,
    this.status,
    this.experimental,
    this.date,
    this.publisher,
    this.contact,
    this.description,
    this.caseSensitive,
    this.content,
    this.valueSet,
    this.hierarchyMeaning,
    this.purpose,
    this.copyright,
    this.property,
    this.concept,
    this.immutable,
    this.jurisdiction,
    this.useContext,
  });

  factory VsResource.fromJson(Map<String, dynamic> json) {
    return VsResource(
      resourceType: json['resourceType'],
      id: json['id'],
      meta: json['meta'] != null ? VsMeta.fromJson(json['meta']) : null,
      text: json['text'] != null ? VsText.fromJson(json['text']) : null,
      extension: json['extension'] != null
          ? (json['extension'] as List).map((e) => VSExtensionItem.fromJson(e)).toList()
          : null,
      url: json['url'],
      identifier: json['identifier'] != null
          ? (json['identifier'] as List).map((e) => VSFilterItem.fromJson(e)).toList()
          : null,
      version: json['version'],
      name: json['name'],
      title: json['title'],
      status: json['status'],
      experimental: json['experimental'],
      date: json['date'],
      publisher: json['publisher'],
      contact: json['contact'] != null
          ? (json['contact'] as List).map((e) => VSContactItem.fromJson(e)).toList()
          : null,
      description: json['description'],
      caseSensitive: json['caseSensitive'],
      content: json['content'],
      valueSet: json['valueSet'],
      hierarchyMeaning: json['hierarchyMeaning'],
      purpose: json['purpose'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
        'resourceType': resourceType,
        'id': id,
        'meta': meta?.toJson(),
        'text': text?.toJson(),
        'extension': extension?.map((e) => e.toJson()).toList(),
        'url': url,
        'identifier': identifier?.map((e) => e.toJson()).toList(),
        'version': version,
        'name': name,
        'title': title,
        'status': status,
        'experimental': experimental,
        'date': date,
        'publisher': publisher,
        'contact': contact?.map((e) => e.toJson()).toList(),
        'description': description,
        'caseSensitive': caseSensitive,
        'content': content,
        'valueSet': valueSet,
        'hierarchyMeaning': hierarchyMeaning,
        'purpose': purpose,
        'copyright': copyright,
        'property': property?.map((e) => e.toJson()).toList(),
        'concept': concept?.map((e) => e.toJson()).toList(),
        'immutable': immutable,
        'jurisdiction': jurisdiction?.map((e) => e.toJson()).toList(),
        'useContext': useContext?.map((e) => e.toJson()).toList(),
      }
      ..removeWhere((key, value) => value == null)
      ..removeWhere((key, value) => value is String && value.isEmpty);
  }
}
