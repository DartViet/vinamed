import 'package:ltdmed/fhir/data_type/v_period.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VContactPoint {
  VCode? system; // phone | fax | email | pager | url | sms | other
  Vstring? value; // The actual contact point details, e.g., phone number, email address
  Vboolean? use; // home | work | temp | old - purpose of this contact
  Vboolean? rank; // The rank of the contact point, used to order multiple contact points
  VPeriod? period; // Time period during which the contact point is valid

  VContactPoint({this.system, this.value, this.use, this.rank, this.period});

  Map<String, dynamic> toJson() {
    return {'system': system, 'value': value, 'use': use, 'rank': rank, 'period': period?.toJson()};
  }

  factory VContactPoint.fromJson(Map<String, dynamic> json) {
    return VContactPoint(
      system: json['system'],
      value: json['value'],
      use: json['use'],
      rank: json['rank'],
      period: json['period'] != null ? VPeriod.fromJson(json['period']) : null,
    );
  }
}
