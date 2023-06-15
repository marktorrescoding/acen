import 'package:flutter/material.dart';

class MyProjects extends ChangeNotifier {
  List<Map<String, String>> _projects = [];

  List<Map<String, String>> get projects => _projects;

  void addProject(String projectName, String grade) {
    _projects.add({
      'name': projectName,
      'grade': grade,
    });
    notifyListeners();
  }

  bool containsProject(String projectName) {
    return _projects.any((project) => project['name'] == projectName);
  }

  void removeProject(String projectName) {
    _projects.removeWhere((project) => project['name'] == projectName);
    notifyListeners();
  }
}
