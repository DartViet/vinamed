// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar.dart';
import 'package:ltdmed/goodies/email_regex.dart';
import 'package:ltdmed/l10n/language_service.dart';
import 'package:ltdmed/goodies/pocketbase_server.dart';
import 'package:ltdmed/named_routes.dart';
import 'package:ltdmed/pages/user_id/sign_up/sign_up_modelview.dart';
import 'package:ltdmed/widgets/fsnackbar.dart';
import 'package:ltdmed/widgets/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  DateTime? selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailFormFieldController = TextEditingController();
  final passwordFormFieldController = TextEditingController();
  final confirmPasswordFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(),
      body: ListenableBuilder(
        listenable: Listenable.merge([SignUpModelview.instance, LanguageService.instance]),
        builder: (context, child) {
          _formKey.currentState?.validate(); // Reset the form state on build
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: [
                        getLogo(context),
                        const SizedBox(height: 16),
                        Center(child: Text(LanguageService.instance.signupCreateAccount, style: Theme.of(context).textTheme.titleLarge)),

                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailFormFieldController,
                          validator: (value) {
                            if (value == null || value.isEmpty || !isValidEmail(value)) {
                              return LanguageService.instance.emailNotValid;
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: LanguageService.instance.email, border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordFormFieldController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || value.trim().length < 8) {
                              return LanguageService.instance.passwordNotValid;
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(labelText: LanguageService.instance.password, border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordFormFieldController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || value.trim() != passwordFormFieldController.text) {
                              return LanguageService.instance.confirmPasswordNotValid;
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: LanguageService.instance.confirmPassword, border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return; // If the form is not valid, do not proceed
                              }
                              PocketBaseServer.instance
                                  .createUser(
                                    email: emailFormFieldController.text.trim().toLowerCase(),
                                    password: passwordFormFieldController.text.trim(),
                                    confirmPassword: confirmPasswordFormFieldController.text.trim(),
                                    context: context,
                                    close: LanguageService.instance.close,
                                  )
                                  .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${LanguageService.instance.userAccountCreated}: ${emailFormFieldController.text.trim().toLowerCase()}'),
                                      ),
                                    );
                                    Navigator.pushNamed(context, NamedRoutes.login);
                                  })
                                  .catchError((error) {
                                    showFSnackBar(context, error.toString());
                                  });
                            },
                            child: Text(LanguageService.instance.signUp),
                          ),
                        ),
                      ],
                    ),
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
