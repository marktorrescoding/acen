import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
    });
  }

  Future<void> _saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    setState(() {
      this.userName = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: userName != null
            ? Text('Welcome, $userName!')
            : ElevatedButton(
          onPressed: () {
            _showUserNameDialog();
          },
          child: Text('Create User Profile'),
        ),
      ),
    );
  }

  void _showUserNameDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? inputUserName;

        return AlertDialog(
          title: Text('Enter your name'),
          content: TextField(
            onChanged: (value) {
              inputUserName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _saveUserName(inputUserName!);
                Navigator.of(context).pop(inputUserName);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        userName = result;
      });
    }
  }
}
