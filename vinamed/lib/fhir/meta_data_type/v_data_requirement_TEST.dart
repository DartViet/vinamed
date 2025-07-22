// FHIR StructureDefinition data model classes
// Represents the structure for HL7 FHIR StructureDefinition resources

class StructureDefinition {
  String? resourceType;
  String? id;
  String? url;
  List<Identifier>? identifier;
  String? version;
  String? versionAlgorithmString;
  Coding? versionAlgorithmCoding;
  String? name;
  String? title;
  String? status;
  bool? experimental;
  String? date;
  String? publisher;
  List<ContactDetail>? contact;
  String? description;
  List<UsageContext>? useContext;
  List<CodeableConcept>? jurisdiction;
  String? purpose;
  String? copyright;
  String? copyrightLabel;
  List<Coding>? keyword;
  String? fhirVersion;
  List<Mapping>? mapping;
  String? kind;
  bool? abstract;
  List<Context>? context;
  List<String>? contextInvariant;
  String? type;
  String? baseDefinition;
  String? derivation;
  Snapshot? snapshot;
  Differential? differential;

  StructureDefinition({
    this.resourceType,
    this.id,
    this.url,
    this.identifier,
    this.version,
    this.versionAlgorithmString,
    this.versionAlgorithmCoding,
    this.name,
    this.title,
    this.status,
    this.experimental,
    this.date,
    this.publisher,
    this.contact,
    this.description,
    this.useContext,
    this.jurisdiction,
    this.purpose,
    this.copyright,
    this.copyrightLabel,
    this.keyword,
    this.fhirVersion,
    this.mapping,
    this.kind,
    this.abstract,
    this.context,
    this.contextInvariant,
    this.type,
    this.baseDefinition,
    this.derivation,
    this.snapshot,
    this.differential,
  });

  factory StructureDefinition.fromJson(Map<String, dynamic> json) {
    return StructureDefinition(
      resourceType: json['resourceType'],
      id: json['id'],
      url: json['url'],
      identifier: json['identifier'] != null ? (json['identifier'] as List).map((e) => Identifier.fromJson(e)).toList() : null,
      version: json['version'],
      versionAlgorithmString: json['versionAlgorithmString'],
      versionAlgorithmCoding: json['versionAlgorithmCoding'] != null ? Coding.fromJson(json['versionAlgorithmCoding']) : null,
      name: json['name'],
      title: json['title'],
      status: json['status'],
      experimental: json['experimental'],
      date: json['date'],
      publisher: json['publisher'],
      contact: json['contact'] != null ? (json['contact'] as List).map((e) => ContactDetail.fromJson(e)).toList() : null,
      description: json['description'],
      useContext: json['useContext'] != null ? (json['useContext'] as List).map((e) => UsageContext.fromJson(e)).toList() : null,
      jurisdiction: json['jurisdiction'] != null ? (json['jurisdiction'] as List).map((e) => CodeableConcept.fromJson(e)).toList() : null,
      purpose: json['purpose'],
      copyright: json['copyright'],
      copyrightLabel: json['copyrightLabel'],
      keyword: json['keyword'] != null ? (json['keyword'] as List).map((e) => Coding.fromJson(e)).toList() : null,
      fhirVersion: json['fhirVersion'],
      mapping: json['mapping'] != null ? (json['mapping'] as List).map((e) => Mapping.fromJson(e)).toList() : null,
      kind: json['kind'],
      abstract: json['abstract'],
      context: json['context'] != null ? (json['context'] as List).map((e) => Context.fromJson(e)).toList() : null,
      contextInvariant: json['contextInvariant'] != null ? List<String>.from(json['contextInvariant']) : null,
      type: json['type'],
      baseDefinition: json['baseDefinition'],
      derivation: json['derivation'],
      snapshot: json['snapshot'] != null ? Snapshot.fromJson(json['snapshot']) : null,
      differential: json['differential'] != null ? Differential.fromJson(json['differential']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceType': resourceType,
      'id': id,
      'url': url,
      'identifier': identifier?.map((e) => e.toJson()).toList(),
      'version': version,
      'versionAlgorithmString': versionAlgorithmString,
      'versionAlgorithmCoding': versionAlgorithmCoding?.toJson(),
      'name': name,
      'title': title,
      'status': status,
      'experimental': experimental,
      'date': date,
      'publisher': publisher,
      'contact': contact?.map((e) => e.toJson()).toList(),
      'description': description,
      'useContext': useContext?.map((e) => e.toJson()).toList(),
      'jurisdiction': jurisdiction?.map((e) => e.toJson()).toList(),
      'purpose': purpose,
      'copyright': copyright,
      'copyrightLabel': copyrightLabel,
      'keyword': keyword?.map((e) => e.toJson()).toList(),
      'fhirVersion': fhirVersion,
      'mapping': mapping?.map((e) => e.toJson()).toList(),
      'kind': kind,
      'abstract': abstract,
      'context': context?.map((e) => e.toJson()).toList(),
      'contextInvariant': contextInvariant,
      'type': type,
      'baseDefinition': baseDefinition,
      'derivation': derivation,
      'snapshot': snapshot?.toJson(),
      'differential': differential?.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}

class Identifier {
  String? system;
  String? value;

  Identifier({this.system, this.value});

  factory Identifier.fromJson(Map<String, dynamic> json) {
    return Identifier(system: json['system'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'value': value}..removeWhere((key, value) => value == null);
  }
}

class Coding {
  String? system;
  String? version;
  String? code;
  String? display;
  bool? userSelected;

  Coding({this.system, this.version, this.code, this.display, this.userSelected});

  factory Coding.fromJson(Map<String, dynamic> json) {
    return Coding(system: json['system'], version: json['version'], code: json['code'], display: json['display'], userSelected: json['userSelected']);
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'version': version, 'code': code, 'display': display, 'userSelected': userSelected}..removeWhere((key, value) => value == null);
  }
}

class ContactDetail {
  String? name;
  List<ContactPoint>? telecom;

  ContactDetail({this.name, this.telecom});

  factory ContactDetail.fromJson(Map<String, dynamic> json) {
    return ContactDetail(name: json['name'], telecom: json['telecom'] != null ? (json['telecom'] as List).map((e) => ContactPoint.fromJson(e)).toList() : null);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'telecom': telecom?.map((e) => e.toJson()).toList()}..removeWhere((key, value) => value == null);
  }
}

class ContactPoint {
  String? system;
  String? value;
  String? use;
  int? rank;

  ContactPoint({this.system, this.value, this.use, this.rank});

  factory ContactPoint.fromJson(Map<String, dynamic> json) {
    return ContactPoint(system: json['system'], value: json['value'], use: json['use'], rank: json['rank']);
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'value': value, 'use': use, 'rank': rank}..removeWhere((key, value) => value == null);
  }
}

class UsageContext {
  Coding? code;
  CodeableConcept? valueCodeableConcept;
  Quantity? valueQuantity;
  Range? valueRange;
  Reference? valueReference;

  UsageContext({this.code, this.valueCodeableConcept, this.valueQuantity, this.valueRange, this.valueReference});

  factory UsageContext.fromJson(Map<String, dynamic> json) {
    return UsageContext(
      code: json['code'] != null ? Coding.fromJson(json['code']) : null,
      valueCodeableConcept: json['valueCodeableConcept'] != null ? CodeableConcept.fromJson(json['valueCodeableConcept']) : null,
      valueQuantity: json['valueQuantity'] != null ? Quantity.fromJson(json['valueQuantity']) : null,
      valueRange: json['valueRange'] != null ? Range.fromJson(json['valueRange']) : null,
      valueReference: json['valueReference'] != null ? Reference.fromJson(json['valueReference']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code?.toJson(),
      'valueCodeableConcept': valueCodeableConcept?.toJson(),
      'valueQuantity': valueQuantity?.toJson(),
      'valueRange': valueRange?.toJson(),
      'valueReference': valueReference?.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}

class CodeableConcept {
  List<Coding>? coding;
  String? text;

  CodeableConcept({this.coding, this.text});

  factory CodeableConcept.fromJson(Map<String, dynamic> json) {
    return CodeableConcept(coding: json['coding'] != null ? (json['coding'] as List).map((e) => Coding.fromJson(e)).toList() : null, text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {'coding': coding?.map((e) => e.toJson()).toList(), 'text': text}..removeWhere((key, value) => value == null);
  }
}

class Quantity {
  double? value;
  String? comparator;
  String? unit;
  String? system;
  String? code;

  Quantity({this.value, this.comparator, this.unit, this.system, this.code});

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(value: json['value']?.toDouble(), comparator: json['comparator'], unit: json['unit'], system: json['system'], code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'comparator': comparator, 'unit': unit, 'system': system, 'code': code}..removeWhere((key, value) => value == null);
  }
}

class Range {
  Quantity? low;
  Quantity? high;

  Range({this.low, this.high});

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(low: json['low'] != null ? Quantity.fromJson(json['low']) : null, high: json['high'] != null ? Quantity.fromJson(json['high']) : null);
  }

  Map<String, dynamic> toJson() {
    return {'low': low?.toJson(), 'high': high?.toJson()}..removeWhere((key, value) => value == null);
  }
}

class Reference {
  String? reference;
  String? type;
  Identifier? identifier;
  String? display;

  Reference({this.reference, this.type, this.identifier, this.display});

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      reference: json['reference'],
      type: json['type'],
      identifier: json['identifier'] != null ? Identifier.fromJson(json['identifier']) : null,
      display: json['display'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'reference': reference, 'type': type, 'identifier': identifier?.toJson(), 'display': display}..removeWhere((key, value) => value == null);
  }
}

class Mapping {
  String? identity;
  String? uri;
  String? name;
  String? comment;

  Mapping({this.identity, this.uri, this.name, this.comment});

  factory Mapping.fromJson(Map<String, dynamic> json) {
    return Mapping(identity: json['identity'], uri: json['uri'], name: json['name'], comment: json['comment']);
  }

  Map<String, dynamic> toJson() {
    return {'identity': identity, 'uri': uri, 'name': name, 'comment': comment}..removeWhere((key, value) => value == null);
  }
}

class Context {
  String? type;
  String? expression;

  Context({this.type, this.expression});

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(type: json['type'], expression: json['expression']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'expression': expression}..removeWhere((key, value) => value == null);
  }
}

class Snapshot {
  List<ElementDefinition>? element;

  Snapshot({this.element});

  factory Snapshot.fromJson(Map<String, dynamic> json) {
    return Snapshot(element: json['element'] != null ? (json['element'] as List).map((e) => ElementDefinition.fromJson(e)).toList() : null);
  }

  Map<String, dynamic> toJson() {
    return {'element': element?.map((e) => e.toJson()).toList()}..removeWhere((key, value) => value == null);
  }
}

class Differential {
  List<ElementDefinition>? element;

  Differential({this.element});

  factory Differential.fromJson(Map<String, dynamic> json) {
    return Differential(element: json['element'] != null ? (json['element'] as List).map((e) => ElementDefinition.fromJson(e)).toList() : null);
  }

  Map<String, dynamic> toJson() {
    return {'element': element?.map((e) => e.toJson()).toList()}..removeWhere((key, value) => value == null);
  }
}

class ElementDefinition {
  String? id;
  String? path;
  List<String>? representation;
  String? sliceName;
  bool? sliceIsConstraining;
  String? label;
  List<Coding>? code;
  ElementDefinitionSlicing? slicing;
  String? short;
  String? definition;
  String? comment;
  String? requirements;
  List<String>? alias;
  int? min;
  String? max;
  ElementDefinitionBase? base;
  String? contentReference;
  List<ElementDefinitionType>? type;
  dynamic defaultValue;
  String? meaningWhenMissing;
  String? orderMeaning;
  dynamic fixed;
  dynamic pattern;
  List<ElementDefinitionExample>? example;
  dynamic minValue;
  dynamic maxValue;
  int? maxLength;
  List<String>? condition;
  List<ElementDefinitionConstraint>? constraint;
  bool? mustSupport;
  bool? isModifier;
  String? isModifierReason;
  bool? isSummary;
  ElementDefinitionBinding? binding;
  List<ElementDefinitionMapping>? mapping;

  ElementDefinition({
    this.id,
    this.path,
    this.representation,
    this.sliceName,
    this.sliceIsConstraining,
    this.label,
    this.code,
    this.slicing,
    this.short,
    this.definition,
    this.comment,
    this.requirements,
    this.alias,
    this.min,
    this.max,
    this.base,
    this.contentReference,
    this.type,
    this.defaultValue,
    this.meaningWhenMissing,
    this.orderMeaning,
    this.fixed,
    this.pattern,
    this.example,
    this.minValue,
    this.maxValue,
    this.maxLength,
    this.condition,
    this.constraint,
    this.mustSupport,
    this.isModifier,
    this.isModifierReason,
    this.isSummary,
    this.binding,
    this.mapping,
  });

  factory ElementDefinition.fromJson(Map<String, dynamic> json) {
    return ElementDefinition(
      id: json['id'],
      path: json['path'],
      representation: json['representation'] != null ? List<String>.from(json['representation']) : null,
      sliceName: json['sliceName'],
      sliceIsConstraining: json['sliceIsConstraining'],
      label: json['label'],
      code: json['code'] != null ? (json['code'] as List).map((e) => Coding.fromJson(e)).toList() : null,
      slicing: json['slicing'] != null ? ElementDefinitionSlicing.fromJson(json['slicing']) : null,
      short: json['short'],
      definition: json['definition'],
      comment: json['comment'],
      requirements: json['requirements'],
      alias: json['alias'] != null ? List<String>.from(json['alias']) : null,
      min: json['min'],
      max: json['max'],
      base: json['base'] != null ? ElementDefinitionBase.fromJson(json['base']) : null,
      contentReference: json['contentReference'],
      type: json['type'] != null ? (json['type'] as List).map((e) => ElementDefinitionType.fromJson(e)).toList() : null,
      defaultValue: json['defaultValue'],
      meaningWhenMissing: json['meaningWhenMissing'],
      orderMeaning: json['orderMeaning'],
      fixed: json['fixed'],
      pattern: json['pattern'],
      example: json['example'] != null ? (json['example'] as List).map((e) => ElementDefinitionExample.fromJson(e)).toList() : null,
      minValue: json['minValue'],
      maxValue: json['maxValue'],
      maxLength: json['maxLength'],
      condition: json['condition'] != null ? List<String>.from(json['condition']) : null,
      constraint: json['constraint'] != null ? (json['constraint'] as List).map((e) => ElementDefinitionConstraint.fromJson(e)).toList() : null,
      mustSupport: json['mustSupport'],
      isModifier: json['isModifier'],
      isModifierReason: json['isModifierReason'],
      isSummary: json['isSummary'],
      binding: json['binding'] != null ? ElementDefinitionBinding.fromJson(json['binding']) : null,
      mapping: json['mapping'] != null ? (json['mapping'] as List).map((e) => ElementDefinitionMapping.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'representation': representation,
      'sliceName': sliceName,
      'sliceIsConstraining': sliceIsConstraining,
      'label': label,
      'code': code?.map((e) => e.toJson()).toList(),
      'slicing': slicing?.toJson(),
      'short': short,
      'definition': definition,
      'comment': comment,
      'requirements': requirements,
      'alias': alias,
      'min': min,
      'max': max,
      'base': base?.toJson(),
      'contentReference': contentReference,
      'type': type?.map((e) => e.toJson()).toList(),
      'defaultValue': defaultValue,
      'meaningWhenMissing': meaningWhenMissing,
      'orderMeaning': orderMeaning,
      'fixed': fixed,
      'pattern': pattern,
      'example': example?.map((e) => e.toJson()).toList(),
      'minValue': minValue,
      'maxValue': maxValue,
      'maxLength': maxLength,
      'condition': condition,
      'constraint': constraint?.map((e) => e.toJson()).toList(),
      'mustSupport': mustSupport,
      'isModifier': isModifier,
      'isModifierReason': isModifierReason,
      'isSummary': isSummary,
      'binding': binding?.toJson(),
      'mapping': mapping?.map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}

// Additional supporting classes for ElementDefinition would be defined here
// (ElementDefinitionSlicing, ElementDefinitionBase, ElementDefinitionType, etc.)
// These are simplified for brevity but would follow the same pattern

class ElementDefinitionSlicing {
  // Simplified implementation
  ElementDefinitionSlicing();

  factory ElementDefinitionSlicing.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionSlicing();
  }
  Map<String, dynamic> toJson() => {};
}

class ElementDefinitionBase {
  // Simplified implementation
  ElementDefinitionBase();

  factory ElementDefinitionBase.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionBase();
  }
  Map<String, dynamic> toJson() => {};
}

class ElementDefinitionType {
  // Simplified implementation
  ElementDefinitionType();

  factory ElementDefinitionType.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionType();
  }
  Map<String, dynamic> toJson() => {};
}

class ElementDefinitionExample {
  // Simplified implementation
  ElementDefinitionExample();

  factory ElementDefinitionExample.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionExample();
  }
  Map<String, dynamic> toJson() => {};
}

class ElementDefinitionConstraint {
  // Simplified implementation
  ElementDefinitionConstraint();

  factory ElementDefinitionConstraint.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionConstraint();
  }
  Map<String, dynamic> toJson() => {};
}

class ElementDefinitionBinding {
  // Simplified implementation
  ElementDefinitionBinding();

  factory ElementDefinitionBinding.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionBinding();
  }
  Map<String, dynamic> toJson() => {};
}

class ElementDefinitionMapping {
  // Simplified implementation
  ElementDefinitionMapping();

  factory ElementDefinitionMapping.fromJson(Map<String, dynamic> json) {
    return ElementDefinitionMapping();
  }
  Map<String, dynamic> toJson() => {};
}
