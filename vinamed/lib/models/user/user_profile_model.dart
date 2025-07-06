import 'package:ltdmed/goodies/pocketbase_server.dart';

class UserProfileModel {
  String userId;
  String fullname;
  String cccdnumber;
  String cmndnumber;
  String dateofbirth;
  String dateofissued;
  String address;
  String phonenumber;
  String gender;
  String id;
  String dbName = 'user_profile';

  static UserProfileModel? _instance;

  UserProfileModel._({
    required this.userId,
    required this.fullname,
    required this.cccdnumber,
    required this.cmndnumber,
    required this.dateofbirth,
    required this.dateofissued,
    required this.address,
    required this.phonenumber,
    required this.gender,
    required this.id,
  });

  static UserProfileModel get instance {
    if (_instance != null) {
      return _instance!;
    }
    UserProfileModel.initialize({});
    return _instance!;
  }

  static void initialize(Map<String, dynamic> json) {
    _instance = UserProfileModel._(
      userId: json['userId'] ?? '',
      fullname: json['fullname'] ?? '',
      cccdnumber: json['cccdnumber'] ?? '',
      cmndnumber: json['cmndnumber'] ?? '',
      dateofbirth: json['dateofbirth'] ?? '',
      dateofissued: json['dateofissued'] ?? '',
      address: json['address'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      gender: json['gender'] ?? '',
      id: json['id'] ?? '',
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    _instance = UserProfileModel._(
      userId: json['userId'] ?? '',
      fullname: json['fullname'] ?? '',
      cccdnumber: json['cccdnumber'] ?? '',
      cmndnumber: json['cmndnumber'] ?? '',
      dateofbirth: json['dateofbirth'] ?? '',
      dateofissued: json['dateofissued'] ?? '',
      address: json['address'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      gender: json['gender'] ?? '',
      id: json['id'] ?? '',
    );
    return _instance!;
  }

  static void clear() {
    _instance = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullname': fullname,
      'cccdnumber': cccdnumber,
      'cmndnumber': cmndnumber,
      'dateofbirth': dateofbirth,
      'dateofissued': dateofissued,
      'address': address,
      'phonenumber': phonenumber,
      'gender': gender,
    };
  }

  Future<void> save() async {
    await PocketBaseServer.instance.recordExistsByFilter(dbName, 'userId="$userId"')
        ? PocketBaseServer.instance.updateItem(dbName, id, toJson())
        : PocketBaseServer.instance.createItem(dbName, toJson());
  }

  Future<void> getUserProfile(String userId) async {
    if (await PocketBaseServer.instance.recordExistsByFilter(dbName, 'userId="$userId"')) {
      final record = await pb.collection(dbName).getFirstListItem('userId="$userId"');
      UserProfileModel.initialize(record.toJson());
    }
  }
}
