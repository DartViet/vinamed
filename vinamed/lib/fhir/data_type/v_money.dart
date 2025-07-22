import 'package:ltdmed/fhir/primitive.dart';

class VMoney {
  Vdecimal? value; // The numerical value of the money
  Vstring? currency; // The currency of the money, represented as a three-letter ISO 4217 code

  VMoney({this.value, this.currency});

  Map<String, dynamic> toJson() {
    return {'value': value, 'currency': currency};
  }

  factory VMoney.fromJson(Map<String, dynamic> json) {
    return VMoney(value: json['value'], currency: json['currency']);
  }
}
