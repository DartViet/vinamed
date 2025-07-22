class VsMeta {
  DateTime lastUpdated;
  List<String>? profiles;

  VsMeta({required this.lastUpdated, this.profiles});
  factory VsMeta.fromJson(Map<String, dynamic> json) {
    return VsMeta(
      lastUpdated: DateTime.parse(json['lastUpdated']),
      profiles: List<String>.from(json['profiles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lastUpdated': lastUpdated.toIso8601String(), 'profiles': profiles}
      ..removeWhere((key, value) => value == null);
  }
}
