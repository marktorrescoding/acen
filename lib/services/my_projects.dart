import 'package:flutter/material.dart';

class MyProjects extends ChangeNotifier {
  // Modify the list to store a Map for each project
  List<Map<String, String>> _projects = [];

  List<Map<String, String>> get projects => _projects;

  // Modify the method to accept both the project name and grade
  void addProject(String projectName, String grade) {
    _projects.add({
      'name': projectName,
      'grade': grade,
    });
    notifyListeners();
  }
}
