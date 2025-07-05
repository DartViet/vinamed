class CodeableConcept {
  final String id;
  final String? extension;
  final String? display;

  CodeableConcept({
    required this.id,
    this.extension,
    this.display,
  });
}
