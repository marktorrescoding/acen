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
            colors: [Colors.greenAccent, Colors.green], // Reversed the order of colors
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
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [Colors.grey[800]!, Colors.black], // Reversed the order of colors
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                'Ascensus',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.landscape,
              color: Colors.black,
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
