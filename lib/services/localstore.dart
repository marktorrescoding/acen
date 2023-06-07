import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static Future<void> saveAreaNames(List<String> areaNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('areaNames', areaNames);
  }

  static Future<List<String>?> getAreaNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('areaNames');
  }
}
