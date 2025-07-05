//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar_viewmodel.dart';
import 'package:ltdmed/named_routes.dart';
import 'package:ltdmed/pages/home/home.dart';
import 'package:ltdmed/pages/qr_scan/qr_scan.dart';
import 'package:ltdmed/pages/user_id/email_verification/email_verification.dart';
import 'package:ltdmed/pages/user_id/forgot_password/forgot_password.dart';
import 'package:ltdmed/pages/user_id/login/login.dart';
import 'package:ltdmed/pages/user_id/sign_up/sign_up.dart';
import 'package:ltdmed/pages/user_info/user_info.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.black, // Or a light shade like Colors.grey[200]
  onPrimary: Colors.white, // Text/icons on primary
  secondary: Colors.white,
  onSecondary: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppbarViewmodel.instance.init();
  //HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vinamed",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: lightColorScheme),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        NamedRoutes.home: (BuildContext context) => HomePage(),
        NamedRoutes.userInfo: (BuildContext context) => UserInfo(),
        NamedRoutes.login: (BuildContext context) => const Login(),
        NamedRoutes.userSignup: (BuildContext context) => const SignUp(),
        NamedRoutes.qrCodeScanner: (BuildContext context) => const MobileScannerSimple(),
        NamedRoutes.verificationEmail: (BuildContext context) => const EmailVerification(),
        NamedRoutes.forgotPassword: (BuildContext context) => const ForgotPassword(),
      },
    );
  }
}

// Uncomment the following code if you need to override HTTP client behavior, such as handling self-signed certificates.
//class MyHttpOverrides extends HttpOverrides {
//  @override
//  HttpClient createHttpClient(SecurityContext? context) {
//    return super.createHttpClient(context)
//      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
//        // Allowing only our Base API URL.
//        return true;
//
//        // return true if you want to allow all host. (This isn't recommended.)
//        // return true;
//      };
//  }
//}
