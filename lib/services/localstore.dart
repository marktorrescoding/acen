import 'package:shared_preferences/shared_preferences.dart';
import 'package:openbeta/models/area.dart';
import 'package:openbeta/models/climb.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStore {
  static Future<void> saveAreas(Area areaData) async {
    final box = await Hive.openBox<Area>('areasBox');
    await box.put(areaData.areaName, areaData);
  }
  static Future<Area?> getArea(String areaName) async {
    final box = await Hive.openBox<Area>('areasBox');
    return box.get(areaName);
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

  static Future<void> saveDownloadedState(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> downloadedStates = prefs.getStringList('downloadedStates') ?? [];
    if (!downloadedStates.contains(state)) {
      downloadedStates.add(state);
      await prefs.setStringList('downloadedStates', downloadedStates);
    }
  }

  static Future<void> deleteDownloadedState(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> downloadedStates = prefs.getStringList('downloadedStates') ?? [];
    downloadedStates.remove(state);
    await prefs.setStringList('downloadedStates', downloadedStates);
  }

  static Future<List<String>> getDownloadedStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('downloadedStates') ?? [];
  }

  static Future<void> deleteState(String state) async {
    final box = await Hive.openBox<Area>('areasBox');
    await box.delete(state);
  }

  static Future<void> updateState(String state, String areaName, bool isLeaf, List<Area> children, List<Climb> climbs) async { // Add climbs as an argument
    final box = await Hive.openBox<Area>('areasBox');
    final existingArea = box.get(state);

    if (existingArea == null) {
      // State not found, handle the error or return
      return;
    }

    final updatedArea = Area(
      areaName: areaName,
      isLeaf: isLeaf,
      children: children,
      climbs: climbs, // Add this
    );

    await box.put(state, updatedArea);
  }

  static Future<void> saveClimb(Climb climb) async {
    final box = await Hive.openBox<Climb>('climbsBox');
    await box.put(climb.name, climb);
  }

  static Future<Climb?> getClimb(String climbName) async {
    final box = await Hive.openBox<Climb>('climbsBox');
    return box.get(climbName);
  }

  static Future<List<Climb>> getAllClimbs() async {
    final box = await Hive.openBox<Climb>('climbsBox');
    return box.values.toList();
  }
}