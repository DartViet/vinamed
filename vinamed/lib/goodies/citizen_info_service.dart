import 'package:ltdmed/l10n/language_service.dart';

class CitizenCardInfo {
  final String cccdNumber;
  final String cmndNumber;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final String placeOfLiving;
  final DateTime dateOfIssued;

  static CitizenCardInfo? _instance;

  CitizenCardInfo._({
    required this.cccdNumber,
    required this.cmndNumber,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.placeOfLiving,
    required this.dateOfIssued,
  });

  static CitizenCardInfo get instance {
    if (_instance == null) {
      fromBarcodeString("| | | | | |"); // Placeholder to ensure instance is created
    }
    return _instance!;
  }

  static CitizenCardInfo fromBarcodeString(String barcodeData) {
    final parts = barcodeData.split('|');

    if (parts.length < 7) {
      throw ArgumentError(LanguageService.instance.invalidQRCode);
    }

    _instance = CitizenCardInfo._(
      cccdNumber: parts[0].trim(),
      cmndNumber: parts[1].trim(),
      fullName: parts[2].trim(),
      dateOfBirth: parts[3].trim().isEmpty ? DateTime.now() : _parseDate(parts[3].trim()),
      gender: parts[4].trim(),
      placeOfLiving: parts[5].trim(),
      dateOfIssued: parts[6].trim().isEmpty ? DateTime.now() : _parseDate(parts[6].trim()),
    );

    return _instance!;
  }

  static void clear() {
    _instance = null;
  }

  static DateTime _parseDate(String dateString) {
    // Assuming format is ddMMyyyy
    if (dateString.length != 8) {
      throw ArgumentError('Invalid date format. Expected ddMMyyyy');
    }

    final day = int.parse(dateString.substring(0, 2));
    final month = int.parse(dateString.substring(2, 4));
    final year = int.parse(dateString.substring(4, 8));

    return DateTime(year, month, day);
  }

  Map<String, dynamic> toJson() {
    return {
      'cccdNumber': cccdNumber,
      'cmndNumber': cmndNumber,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'placeOfLiving': placeOfLiving,
      'dateOfIssued': dateOfIssued.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CitizenInfo(cccd: $cccdNumber, cmnd: $cmndNumber, name: $fullName, dob: ${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}, gender: $gender, address: $placeOfLiving, issued: ${dateOfIssued.day}/${dateOfIssued.month}/${dateOfIssued.year})';
  }
}
