import 'package:flutter/material.dart';

class MyProjects extends ChangeNotifier {
  List<String> _projects = [];

  List<String> get projects => _projects;

  void addProject(String projectName) {
    _projects.add(projectName);
    notifyListeners();
  }
}
