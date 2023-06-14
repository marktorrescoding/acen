import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbeta/models/area.dart';

// Initialize the app, register Hive adapter
Future<void> initializeApp() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AreaAdapter());
}