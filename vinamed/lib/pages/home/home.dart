import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar.dart';
import 'package:ltdmed/drawer/drawer.dart';
import 'package:ltdmed/l10n/language_service.dart';
import 'package:ltdmed/models/user/user_model.dart';
import 'package:ltdmed/named_routes.dart';
import 'package:ltdmed/pages/home/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    getGridCount() {
      int count = MediaQuery.of(context).size.width ~/ 300;
      if (count > 4) {
        count = 4;
      }

      return count;
    }

    if (UserModel.instance.email.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, NamedRoutes.login);
      });
    }

    return Scaffold(
      appBar: FAppbar(),
      drawer: FDrawer().getDrawer(context),
      body: ListenableBuilder(
        listenable: Listenable.merge([HomeViewModel.instance, LanguageService.instance]),
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: GridView.count(
                childAspectRatio: 1.75,
                crossAxisCount: getGridCount(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  getCard(LanguageService.instance.userInfo, NamedRoutes.userInfo, Icons.person),
                  getCard(LanguageService.instance.healthRecord, NamedRoutes.home, Icons.home),
                  getCard(LanguageService.instance.healthRecord, "/healthRecord", Icons.health_and_safety),
                  getCard(LanguageService.instance.admin, "/admin", Icons.admin_panel_settings),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, tooltip: 'Increment Age', child: const Icon(Icons.add)),
    );
  }

  Widget getCard(String title, String namedRoute, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, namedRoute);
              },
              icon: Icon(icon, size: 50, color: Theme.of(context).primaryColor),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, namedRoute);
              },
              child: Center(child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall)),
            ),
          ],
        ),
      ),
    );
  }
}
