class VSExtensionItem {
  String url;
  String valueCode;
  int valueInteger;

  VSExtensionItem({required this.url, required this.valueCode, required this.valueInteger});

  factory VSExtensionItem.fromJson(Map<String, dynamic> json) {
    return VSExtensionItem(
      url: json['url'],
      valueCode: json['valueCode'],
      valueInteger: json['valueInteger'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'valueCode': valueCode, 'valueInteger': valueInteger}
      ..removeWhere((key, value) => value == null || (value is String && value.isEmpty));
  }
}
