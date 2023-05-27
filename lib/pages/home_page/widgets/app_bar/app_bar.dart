import 'package:flutter/material.dart';
import 'package:openbeta/pages/home_page/widgets/app_bar/user_profile_icon.dart';
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
            colors: [Color(0xFF00BFA5), Color(0xFF00ACC1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      centerTitle: true,
      title: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [Colors.black, Colors.grey[800]!], // Use Colors.grey[800] for a darker gray
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
      actions: [
        UserProfile(),
        SettingsButton(),
      ],
    );
  }
}