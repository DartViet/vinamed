class VsText {
  String status;
  String? div;

  VsText({required this.status, this.div});

  factory VsText.fromJson(Map<String, dynamic> json) {
    return VsText(status: json['status'], div: json['div']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'div': div}..removeWhere((key, value) => value == null);
  }
}
