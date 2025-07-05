// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar.dart';
import 'package:ltdmed/goodies/server_ip.dart';
import 'package:ltdmed/l10n/language_service.dart';
import 'package:ltdmed/named_routes.dart';
import 'package:ltdmed/widgets/fsnackbar.dart';
import 'package:ltdmed/widgets/logo.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<StatefulWidget> createState() {
    return EmailVerificationState();
  }
}

class EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(hideUserIcon: true),
      body: ListenableBuilder(
        listenable: Listenable.merge([LanguageService.instance]),
        builder: (context, widget) {
          return Center(
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLogo(context),
                Text(LanguageService.instance.pleaseCheckYourEmail, textAlign: TextAlign.center),
                Text(LanguageService.instance.cannotFindEmail, style: Theme.of(context).textTheme.bodySmall),
                ElevatedButton(
                  onPressed: () {
                    PocketBaseServer.instance
                        .verifyEmail()
                        .then((_) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(LanguageService.instance.emailVerificationSent),
                                content: Text(LanguageService.instance.emailVerificationSentBody),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      PocketBaseServer.instance.logoutUser().then((_) {
                                        Navigator.of(context).pop();
                                        while (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                        Navigator.pushReplacementNamed(context, NamedRoutes.login);
                                      });
                                    },
                                    child: Text(LanguageService.instance.ok),
                                  ),
                                ],
                              );
                            },
                          );
                        })
                        .catchError((error) {
                          showFSnackBar(context, error.toString());
                        });
                  },
                  child: Text(LanguageService.instance.sendVerificationEmail),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              ],
            ),
          );
        },
      ),
    );
  }
}
