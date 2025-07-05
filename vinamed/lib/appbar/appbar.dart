import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar_viewmodel.dart';
import 'package:ltdmed/models/user/user_model.dart';
import 'package:ltdmed/named_routes.dart';

class FAppbar extends StatefulWidget implements PreferredSizeWidget {
  const FAppbar({super.key, this.hideUserIcon = false});

  final bool hideUserIcon;

  @override
  State<StatefulWidget> createState() {
    return FAppbarState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class FAppbarState extends State<FAppbar> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppbarViewmodel.instance,
      builder: (context, child) {
        return AppBar(
          title: Center(child: Text(AppbarViewmodel.instance.title)),
          actions: <Widget>[
            widget.hideUserIcon
                ? Container()
                : IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    if (UserModel.instance.email.isNotEmpty) {
                      Navigator.pushNamed(context, NamedRoutes.userInfo);
                    } else {
                      Navigator.pushNamed(context, NamedRoutes.login);
                    }
                  },
                ),

            PopupMenuButton(
              icon: const Icon(Icons.translate),
              onSelected: (String lang) {
                AppbarViewmodel.instance.changeLang(lang);
              },
              itemBuilder: (BuildContext context) {
                return AppbarViewmodel.instance.langs.map((String lang) {
                  return PopupMenuItem<String>(value: lang, child: Text(lang));
                }).toList();
              },
            ),
          ],
        );
      },
    );
  }
}
