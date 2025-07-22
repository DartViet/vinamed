// FHIR CodeSystem data model classes
// Represents the structure for HL7 FHIR CodeSystem resources

class CodeSystem {
  String? resourceType;
  String? id;
  String? language;
  Narrative? text;
  String? url;
  List<Identifier>? identifier;
  String? version;
  String? name;
  String? title;
  String? status;
  bool? experimental;
  String? date;
  String? publisher;
  List<Contact>? contact;
  String? description;
  bool? caseSensitive;
  String? hierarchyMeaning;
  String? content;
  List<Property>? property;
  List<Concept>? concept;

  CodeSystem({
    this.resourceType,
    this.id,
    this.language,
    this.text,
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
    this.hierarchyMeaning,
    this.content,
    this.property,
    this.concept,
  });

  factory CodeSystem.fromJson(Map<String, dynamic> json) {
    return CodeSystem(
      resourceType: json['resourceType'],
      id: json['id'],
      language: json['language'],
      text: json['text'] != null ? Narrative.fromJson(json['text']) : null,
      url: json['url'],
      identifier: json['identifier'] != null ? (json['identifier'] as List).map((e) => Identifier.fromJson(e)).toList() : null,
      version: json['version'],
      name: json['name'],
      title: json['title'],
      status: json['status'],
      experimental: json['experimental'],
      date: json['date'],
      publisher: json['publisher'],
      contact: json['contact'] != null ? (json['contact'] as List).map((e) => Contact.fromJson(e)).toList() : null,
      description: json['description'],
      caseSensitive: json['caseSensitive'],
      hierarchyMeaning: json['hierarchyMeaning'],
      content: json['content'],
      property: json['property'] != null ? (json['property'] as List).map((e) => Property.fromJson(e)).toList() : null,
      concept: json['concept'] != null ? (json['concept'] as List).map((e) => Concept.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceType': resourceType,
      'id': id,
      'language': language,
      'text': text?.toJson(),
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
      'hierarchyMeaning': hierarchyMeaning,
      'content': content,
      'property': property?.map((e) => e.toJson()).toList(),
      'concept': concept?.map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}

class Narrative {
  String? status;
  String? div;

  Narrative({this.status, this.div});

  factory Narrative.fromJson(Map<String, dynamic> json) {
    return Narrative(status: json['status'], div: json['div']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'div': div}..removeWhere((key, value) => value == null);
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

class Contact {
  String? name;

  Contact({this.name});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name}..removeWhere((key, value) => value == null);
  }
}

class Property {
  List<Extension>? extension;
  String? code;
  String? uri;
  String? description;
  String? type;

  Property({this.extension, this.code, this.uri, this.description, this.type});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      extension: json['extension'] != null ? (json['extension'] as List).map((e) => Extension.fromJson(e)).toList() : null,
      code: json['code'],
      uri: json['uri'],
      description: json['description'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'extension': extension?.map((e) => e.toJson()).toList(), 'code': code, 'uri': uri, 'description': description, 'type': type}
      ..removeWhere((key, value) => value == null);
  }
}

class Extension {
  String? url;
  String? valueCode;
  bool? valueBoolean;
  String? valueString;

  Extension({this.url, this.valueCode, this.valueBoolean, this.valueString});

  factory Extension.fromJson(Map<String, dynamic> json) {
    return Extension(url: json['url'], valueCode: json['valueCode'], valueBoolean: json['valueBoolean'], valueString: json['valueString']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'valueCode': valueCode, 'valueBoolean': valueBoolean, 'valueString': valueString}..removeWhere((key, value) => value == null);
  }
}

class Concept {
  String? code;
  String? display;
  String? definition;
  List<ConceptProperty>? property;
  List<Concept>? concept; // Nested concepts for hierarchical structure

  Concept({this.code, this.display, this.definition, this.property, this.concept});

  factory Concept.fromJson(Map<String, dynamic> json) {
    return Concept(
      code: json['code'],
      display: json['display'],
      definition: json['definition'],
      property: json['property'] != null ? (json['property'] as List).map((e) => ConceptProperty.fromJson(e)).toList() : null,
      concept: json['concept'] != null ? (json['concept'] as List).map((e) => Concept.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'display': display,
      'definition': definition,
      'property': property?.map((e) => e.toJson()).toList(),
      'concept': concept?.map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}

class ConceptProperty {
  String? code;
  String? valueCode;
  String? valueString;
  bool? valueBoolean;

  ConceptProperty({this.code, this.valueCode, this.valueString, this.valueBoolean});

  factory ConceptProperty.fromJson(Map<String, dynamic> json) {
    return ConceptProperty(code: json['code'], valueCode: json['valueCode'], valueString: json['valueString'], valueBoolean: json['valueBoolean']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'valueCode': valueCode, 'valueString': valueString, 'valueBoolean': valueBoolean}..removeWhere((key, value) => value == null);
  }
}
