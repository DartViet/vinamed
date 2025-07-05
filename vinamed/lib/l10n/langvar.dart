import 'dart:convert';

import 'package:flutter/services.dart';

class LangUtility {
  static Map<String, dynamic> _langJson = {};

  static Future<Map<String, dynamic>> get langJson async {
    if (_langJson.isEmpty) {
      String langStr = await rootBundle.loadString("assets/lang.json");
      _langJson = json.decode(langStr);
    }
    return _langJson;
  }

  static Future<String> getString(String val, String lang) async {
    Map<String, dynamic> langJson = await LangUtility.langJson;

    if (await langJson[val] == null) {
      return val;
    }
    if (langJson[val][lang] == null) {
      return langJson[val][lang] ?? val;
    }
    return langJson[val][lang];
  }

  static getAllLanguages() async {
    Map<String, dynamic> langJson = await LangUtility.langJson;
    List<String> langs = langJson[LangVar.title].keys.toList();
    return langs;
  }
}

class LangVar {
  static String en = "en";
  static String vi = "vi";
  static String zh = "zh";

  static const String title = "title";
  static const String userInfo = "userInfo";
  static const String healthRecord = "healthRecord";
  static const String staff = "staff";
  static const String admin = "admin";
  static const String homePage = "homePage";
  static const String commonLogin = "commonLogin";
  static const String commonLogout = "commonLogout";

  static const String signUp = "signUp";
  static const String signIn = "signIn";
  static const String forgotPassword = "forgotPassword";
  static const String passwordNotCorrect = "passwordNotCorrect";
  static const String email = "email";
  static const String password = "password";
  static const String signinpageWelcome = "signinpageWelcome";

  static const String signupCreateAccount = "signupCreateAccount";
  static const String signupConfirmPassword = "signupConfirmPassword";
  static const String emailNotValid = "emailNotValid";
  static const String passwordNotValid = "passwordNotValid";
  static const String confirmPasswordNotValid = "confirmPasswordNotValid";
  static const String close = "close";
  static const String userAccountCreated = "userAccountCreated";

  static const String userInfoFullName = "userInfoFullName";
  static const String userInfoPhoneNumber = "userInfoPhoneNumber";
  static const String userInfoAddress = "userInfoAddress";
  static const String userInfoDateOfBirth = "userInfoDateOfBirth";
  static const String userInfoGender = "userInfoGender";
  static const String male = "male";
  static const String female = "female";
  static const String userInfoDateIssued = "userInfoDateIssued";
  static const String userInfoPlaceIssued = "userInfoPlaceIssued";
  static const String userInfoCCCD = "userInfoCCCD";
  static const String userInfoCMND = "userInfoCMND";
  static const String userInfoTitle = "userInfoTitle";
  static const String userInfoSelectDate = "userInfoSelectDate";
  static const String userInfoScanIDQRCode = "userInfoScanIDQRCode";
  static const String qrscanScanning = "qrscanScanning";
  static const String userInfoFullNameNotValid = "userInfoFullNameNotValid";
  static const String userInfoPhoneNumberNotValid = "userInfoPhoneNumberNotValid";
  static const String userInfoAddressNotValid = "userInfoAddressNotValid";
  static const String userInfoDateOfBirthNotValid = "userInfoDateOfBirthNotValid";
  static const String userInfoDateIssuedNotValid = "userInfoDateIssuedNotValid";
  static const String userInfoPlaceIssuedNotValid = "userInfoPlaceIssuedNotValid";
  static const String userInfoCCCDNotValid = "userInfoCCCDNotValid";
  static const String userInfoCMNDNotValid = "userInfoCMNDNotValid";
  static const String saveSuccess = "saveSuccess";
  static const String save = "save";
  static const String pleaseCheckYourEmail = "pleaseCheckYourEmail";
  static const String cannotFindEmail = "cannotFindEmail";
  static const String ok = "ok";
  static const String emailVerificationSent = "emailVerificationSent";
  static const String emailVerificationSentBody = "emailVerificationSentBody";
  static const String sendVerificationEmail = "sendVerificationEmail";
  static const String enterEmailToResetPassword = "enterEmailToResetPassword";
  static const String submit = "submit";
  static const String resetPasswordEmailSent = "resetPasswordEmailSent";
  static const String invalidQRCode = "invalidQRCode";
}
