import 'package:ltdmed/fhir/data_type/v_period.dart';
import 'package:ltdmed/fhir/data_type/v_quantity.dart';
import 'package:ltdmed/fhir/data_type/v_range.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VRepeat {
  VDuration? boundsDuration; // Duration of the repeat
  VRange? boundsRange;
  VPeriod? boundsPeriod; // Period of the repeat
  VpositiveInt? count; // Number of times to repeat
  VpositiveInt? countMax; // Maximum number of times to repeat
  Vdecimal? duration; // Duration of each repeat
  Vdecimal? durationMax; // Maximum duration of each repeat
  VCode? durationUnit; // s | min | h | d | wk | mo | a - unit of time (UCUM)
  VpositiveInt? frequency; // Frequency of the repeat
  VpositiveInt? frequencyMax; // Maximum frequency of the repeat
  Vdecimal? period; // Period of the repeat
  Vdecimal? periodMax; // Maximum period of the repeat
  VCode? periodUnit; // s | min | h | d | wk | mo | a - unit of time (UCUM)
  List<VCode>? dayOfWeek; // Days of the week for the repeat (e.g., 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN')
  List<Vtime>? timeOfDay; // Specific times of day for the repeat
  VCode? when; // Code for when the repeat occurs (e.g., 'MORN', 'NOON', 'EVE', 'NIGHT')
  VunsignedInt? offset; // Offset from the start of the period

  VRepeat({
    this.boundsDuration,
    this.boundsRange,
    this.boundsPeriod,
    this.count,
    this.countMax,
    this.duration,
    this.durationMax,
    this.durationUnit,
    this.frequency,
    this.frequencyMax,
    this.period,
    this.periodMax,
    this.periodUnit,
    this.dayOfWeek,
    this.timeOfDay,
    this.when,
    this.offset,
  });

  Map<String, dynamic> toJson() {
    return {
      'boundsDuration': boundsDuration?.toJson(),
      'boundsRange': boundsRange?.toJson(),
      'boundsPeriod': boundsPeriod?.toJson(),
      'count': count,
      'countMax': countMax,
      'duration': duration,
      'durationMax': durationMax,
      'durationUnit': durationUnit,
      'frequency': frequency,
      'frequencyMax': frequencyMax,
      'period': period,
      'periodMax': periodMax,
      'periodUnit': periodUnit,
      'dayOfWeek': dayOfWeek?.map((e) => e.toString()).toList(),
      'timeOfDay': timeOfDay?.toString(),
      'when': when,
      'offset': offset,
    };
  }

  factory VRepeat.fromJson(Map<String, dynamic> json) {
    return VRepeat(
      boundsDuration: json['boundsDuration'] != null ? VDuration.fromJson(json['boundsDuration']) : null,
      boundsRange: json['boundsRange'] != null ? VRange.fromJson(json['boundsRange']) : null,
      boundsPeriod: json['boundsPeriod'] != null ? VPeriod.fromJson(json['boundsPeriod']) : null,
      count: json['count'],
      countMax: json['countMax'],
      duration: json['duration'],
      durationMax: json['durationMax'],
      durationUnit: json['durationUnit'],
      frequency: json['frequency'],
      frequencyMax: json['frequencyMax'],
      period: json['period'],
      periodMax: json['periodMax'],
      periodUnit: json['periodUnit'],
      dayOfWeek: (json['dayOfWeek'] as List?)?.map((e) => e.toString()).toList(),
      timeOfDay: (json['timeOfDay'] as List?)?.map((e) => e.toString()).toList(),
      when: json['when'],
      offset: json['offset'],
    );
  }
}
