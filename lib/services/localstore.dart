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

  static Future<List<String>> getDownloadedAreas() async {
    List<String>? areaNames = await getAreaNames();
    return areaNames ?? [];
  }

  static Future<bool> isAreaDownloaded(String state) async {
    List<String> downloadedAreas = await getDownloadedAreas();
    return downloadedAreas.contains(state);
  }

  static Future<void> deleteAreaNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('areaNames');
  }
}
