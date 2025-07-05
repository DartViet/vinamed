import 'package:ltdmed/goodies/server_ip.dart';

class UserModel {
  String avatar;
  String collectionId;
  String collectionName;
  DateTime created;
  String email;
  bool emailVisibility;
  String id;
  String name;
  DateTime updated;
  bool verified;
  String userProfileCollection = 'user_profile';

  static UserModel? _instance;

  UserModel._({
    required this.avatar,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.email,
    required this.emailVisibility,
    required this.id,
    required this.name,
    required this.updated,
    required this.verified,
  });

  static UserModel get instance {
    if (_instance == null) {
      initialize({});
    }
    return _instance!;
  }

  static void initialize(Map<String, dynamic> json) {
    _instance = UserModel._(
      avatar: json['avatar'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      created: DateTime.parse(json['created'] ?? DateTime.now().toString()),
      email: json['email'] ?? '',
      emailVisibility: json['emailVisibility'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      updated: DateTime.parse(json['updated'] ?? DateTime.now().toString()),
      verified: json['verified'] ?? false,
    );
  }

  static void clear() {
    _instance = null;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    _instance = UserModel._(
      avatar: json['avatar'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      created: DateTime.parse(json['created']),
      email: json['email'] ?? '',
      emailVisibility: json['emailVisibility'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      updated: DateTime.parse(json['updated']),
      verified: json['verified'] ?? false,
    );
    return _instance!;
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created.toIso8601String(),
      'email': email,
      'emailVisibility': emailVisibility,
      'id': id,
      'name': name,
      'updated': updated.toIso8601String(),
      'verified': verified,
    };
  }

  Future<void> getUserInfo(String userId) async {
    pb
        .collection('users')
        .getOne(userId)
        .then((value) {
          UserModel.fromJson(value.toJson());
        })
        .catchError((error) {
          throw Exception('Failed to fetch user info: $error');
        });
  }
}
