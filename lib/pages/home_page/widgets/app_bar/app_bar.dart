import 'package:flutter/material.dart';
import 'package:openbeta/pages/home_page/widgets/app_bar/user_profile.dart';
import 'package:openbeta/pages/home_page/widgets/app_bar/settings_button.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00CC99), Color(0xFF33D6AA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      centerTitle: true,
      leading: Container(),
      title: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ascensus',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.landscape,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
      actions: [
        UserProfile(),
        SettingsButton(),
      ],
    );
  }
}
