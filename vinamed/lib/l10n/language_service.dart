import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar_viewmodel.dart';
import 'package:ltdmed/l10n/langvar.dart';
import 'package:ltdmed/models/base_model.dart';

class LanguageService extends ChangeNotifier implements BaseModel {
  static LanguageService? _instance;
  static LanguageService get instance {
    _instance ??= LanguageService();
    return _instance!;
  }

  String homePage = "";
  String userInfo = "";
  String healthRecord = "";
  String staff = "";
  String admin = "";
  String login = "";
  String logout = "";
  String email = "";
  String password = "";
  String signup = "";
  String signin = "";
  String forgotPassword = "";
  String passwordNotCorrect = "";
  String welcome = "";
  String usernameNotValid = "";
  String confirmPassword = '';
  String signUp = '';
  String signupCreateAccount = '';
  String emailNotValid = '';
  String passwordNotValid = '';
  String confirmPasswordNotValid = '';
  String close = '';
  String userAccountCreated = '';
  String fullName = '';
  String cccdNumber = '';
  String phoneNumber = '';
  String address = '';
  String cmndNumber = '';
  String dateOfBirth = '';
  String dateOfIssue = '';
  String placeOfIssue = '';
  String gender = '';
  String userInfoTitle = '';
  String male = '';
  String female = '';
  String selecteDate = '';
  String title = "";
  String userInfoScanIDQRCode = '';
  String qrscanScanning = '';
  String userInfoFullNameNotValid = '';
  String userInfoPhoneNumberNotValid = '';
  String userInfoAddressNotValid = '';
  String userInfoDateOfBirthNotValid = '';
  String userInfoDateIssuedNotValid = '';
  String userInfoPlaceIssuedNotValid = '';
  String userInfoCCCDNotValid = '';
  String userInfoCMNDNotValid = '';
  String save = '';
  String saveSuccess = '';
  String pleaseCheckYourEmail = '';
  String cannotFindEmail = '';
  String ok = '';
  String emailVerificationSent = '';
  String emailVerificationSentBody = '';
  String sendVerificationEmail = '';
  String enterEmailToResetPassword = '';
  String submit = '';
  String resetPasswordEmailSent = '';
  String invalidQRCode = '';

  @override
  Future<void> changeLang(String lang) {
    return _changeLang(lang);
  }

  Future<void> init() async {
    _instance = this;
    await _changeLang(AppbarViewmodel.instance.currentLang); // Default language
    notifyListeners();
  }

  Future<void> _changeLang(String lang) async {
    userInfo = await LangUtility.getString(LangVar.userInfo, lang);
    healthRecord = await LangUtility.getString(LangVar.healthRecord, lang);
    staff = await LangUtility.getString(LangVar.staff, lang);
    admin = await LangUtility.getString(LangVar.admin, lang);
    homePage = await LangUtility.getString(LangVar.homePage, lang);
    login = await LangUtility.getString(LangVar.commonLogin, lang);
    logout = await LangUtility.getString(LangVar.commonLogout, lang);
    email = await LangUtility.getString(LangVar.email, lang);
    password = await LangUtility.getString(LangVar.password, lang);
    signup = await LangUtility.getString(LangVar.signUp, lang);
    signin = await LangUtility.getString(LangVar.signIn, lang);
    forgotPassword = await LangUtility.getString(LangVar.forgotPassword, lang);
    passwordNotCorrect = await LangUtility.getString(LangVar.passwordNotCorrect, lang);
    welcome = await LangUtility.getString(LangVar.signinpageWelcome, lang);
    usernameNotValid = await LangUtility.getString(LangVar.emailNotValid, lang);
    signUp = await LangUtility.getString(LangVar.signUp, lang);
    signupCreateAccount = await LangUtility.getString(LangVar.signupCreateAccount, lang);
    confirmPassword = await LangUtility.getString(LangVar.signupConfirmPassword, lang);
    emailNotValid = await LangUtility.getString(LangVar.emailNotValid, lang);
    passwordNotValid = await LangUtility.getString(LangVar.passwordNotValid, lang);
    confirmPasswordNotValid = await LangUtility.getString(LangVar.confirmPasswordNotValid, lang);
    close = await LangUtility.getString(LangVar.close, lang);
    userAccountCreated = await LangUtility.getString(LangVar.userAccountCreated, lang);
    fullName = await LangUtility.getString(LangVar.userInfoFullName, lang);
    cccdNumber = await LangUtility.getString(LangVar.userInfoCCCD, lang);
    phoneNumber = await LangUtility.getString(LangVar.userInfoPhoneNumber, lang);
    address = await LangUtility.getString(LangVar.userInfoAddress, lang);
    cmndNumber = await LangUtility.getString(LangVar.userInfoCMND, lang);
    dateOfBirth = await LangUtility.getString(LangVar.userInfoDateOfBirth, lang);
    dateOfIssue = await LangUtility.getString(LangVar.userInfoDateIssued, lang);
    placeOfIssue = await LangUtility.getString(LangVar.userInfoPlaceIssued, lang);
    gender = await LangUtility.getString(LangVar.userInfoGender, lang);
    userInfoTitle = await LangUtility.getString(LangVar.userInfo, lang);
    male = await LangUtility.getString(LangVar.male, lang);
    female = await LangUtility.getString(LangVar.female, lang);
    selecteDate = await LangUtility.getString(LangVar.userInfoSelectDate, lang);
    title = await LangUtility.getString(LangVar.homePage, lang);
    userInfoScanIDQRCode = await LangUtility.getString(LangVar.userInfoScanIDQRCode, lang);
    qrscanScanning = await LangUtility.getString(LangVar.qrscanScanning, lang);
    userInfoFullNameNotValid = await LangUtility.getString(LangVar.userInfoFullNameNotValid, lang);
    userInfoPhoneNumberNotValid = await LangUtility.getString(LangVar.userInfoPhoneNumberNotValid, lang);
    userInfoAddressNotValid = await LangUtility.getString(LangVar.userInfoAddressNotValid, lang);
    userInfoDateOfBirthNotValid = await LangUtility.getString(LangVar.userInfoDateOfBirthNotValid, lang);
    userInfoDateIssuedNotValid = await LangUtility.getString(LangVar.userInfoDateIssuedNotValid, lang);
    userInfoPlaceIssuedNotValid = await LangUtility.getString(LangVar.userInfoPlaceIssuedNotValid, lang);
    userInfoCCCDNotValid = await LangUtility.getString(LangVar.userInfoCCCDNotValid, lang);
    userInfoCMNDNotValid = await LangUtility.getString(LangVar.userInfoCMNDNotValid, lang);
    save = await LangUtility.getString(LangVar.save, lang);
    saveSuccess = await LangUtility.getString(LangVar.saveSuccess, lang);
    pleaseCheckYourEmail = await LangUtility.getString(LangVar.pleaseCheckYourEmail, lang);
    cannotFindEmail = await LangUtility.getString(LangVar.cannotFindEmail, lang);
    ok = await LangUtility.getString(LangVar.ok, lang);
    emailVerificationSent = await LangUtility.getString(LangVar.emailVerificationSent, lang);
    emailVerificationSentBody = await LangUtility.getString(LangVar.emailVerificationSentBody, lang);
    sendVerificationEmail = await LangUtility.getString(LangVar.sendVerificationEmail, lang);
    enterEmailToResetPassword = await LangUtility.getString(LangVar.enterEmailToResetPassword, lang);
    submit = await LangUtility.getString(LangVar.submit, lang);
    resetPasswordEmailSent = await LangUtility.getString(LangVar.resetPasswordEmailSent, lang);
    invalidQRCode = await LangUtility.getString(LangVar.invalidQRCode, lang);

    notifyListeners();
  }
}
