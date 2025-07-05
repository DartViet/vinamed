import 'package:flutter/material.dart';
import 'package:ltdmed/goodies/citizen_info_service.dart';
import 'package:ltdmed/models/user/user_model.dart';
import 'package:ltdmed/models/user/user_profile_model.dart';
import 'package:pocketbase/pocketbase.dart';

//String pockbaseServerIp = "https://localhost:2901";
//String hapiServerIp = "https://localhost:2900";

String pockbaseServerIp = "https://ltd.zapto.org/pocketbase";
String hapiServerIp = "https://ltd.zapto.org";
final PocketBase pb = PocketBase(pockbaseServerIp);

class PocketBaseServer {
  static PocketBaseServer? _instance;

  static PocketBaseServer get instance {
    _instance ??= PocketBaseServer();
    return _instance!;
  }

  String usersCollection = "users";

  Future<RecordModel> createUser({
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
    String close = 'close',
  }) async {
    final record = await pb.collection(usersCollection).create(body: {'email': email, 'password': password, 'passwordConfirm': confirmPassword});
    return record;
  }

  Future<RecordAuth> authenticateUser({required String email, required String password, required BuildContext context}) async {
    RecordAuth auth = await pb.collection(usersCollection).authWithPassword(email, password);
    UserModel.initialize(auth.record.toJson());

    return auth;
  }

  Future<void> logoutUser() async {
    UserModel.clear();
    UserProfileModel.clear();
    CitizenCardInfo.clear();
    pb.authStore.clear();
  }

  Future<RecordModel> createItem(String itemName, Map<String, dynamic> body) async {
    return pb.collection(itemName).create(body: body);
  }

  Future<RecordModel> updateItem(String itemName, String itemId, Map<String, dynamic> body) async {
    return pb.collection(itemName).update(itemId, body: body);
  }

  Future<bool> recordExistsByFilter(String collectionName, String filter) async {
    try {
      final result = await pb.collection(collectionName).getList(page: 1, perPage: 1, filter: filter);
      return result.items.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await pb.collection(usersCollection).requestPasswordReset(email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> verifyEmail() async {
    await pb.collection(usersCollection).requestVerification(UserModel.instance.email);
  }
}
