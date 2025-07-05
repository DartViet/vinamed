// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar.dart';
import 'package:ltdmed/goodies/email_regex.dart';
import 'package:ltdmed/goodies/server_ip.dart' show PocketBaseServer;
import 'package:ltdmed/l10n/language_service.dart';
import 'package:ltdmed/named_routes.dart';
import 'package:ltdmed/widgets/fsnackbar.dart';
import 'package:ltdmed/widgets/logo.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailFormFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(hideUserIcon: true),
      body: ListenableBuilder(
        listenable: Listenable.merge([LanguageService.instance]),
        builder: (context, widget) {
          return Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      getLogo(context),
                      Text(LanguageService.instance.enterEmailToResetPassword, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center),
                      TextFormField(
                        controller: emailFormFieldController,
                        decoration: InputDecoration(labelText: LanguageService.instance.email, border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty || !isValidEmail(value)) {
                            return LanguageService.instance.emailNotValid;
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            PocketBaseServer.instance
                                .resetPassword(emailFormFieldController.text.trim().toLowerCase())
                                .then((_) {
                                  showFSnackBar(context, LanguageService.instance.resetPasswordEmailSent);
                                  Navigator.pushReplacementNamed(context, NamedRoutes.login);
                                })
                                .catchError((error) {
                                  showFSnackBar(context, error.toString());
                                });
                          }
                        },
                        child: Text(LanguageService.instance.submit, style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
