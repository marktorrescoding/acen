import 'package:flutter/material.dart';

// MyProjects class is a ChangeNotifier which means it notifies all its listeners when a change occurs in it
class MyProjects extends ChangeNotifier {

  // _projects is a private list containing map of String key-value pairs. It's a list of projects with their names and grades.
  final List<Map<String, String>> _projects = [];

  // Getter for _projects. It's public so it can be accessed from outside this class
  List<Map<String, String>> get projects => _projects;

  // Method to add a new project to the _projects list
  void addProject(String projectName, String grade) {
    // Adds a new project to the _projects list
    _projects.add({
      'name': projectName,
      'grade': grade,
    });
    // After adding a new project, it notifies all its listeners about this change
    notifyListeners();
  }

  // Method to check if a project with a given name already exists in the _projects list
  bool containsProject(String projectName) {
    // Using the .any method to check if the project name exists in the list
    return _projects.any((project) => project['name'] == projectName);
  }

  // Method to remove a project with a given name from the _projects list
  void removeProject(String projectName) {
    // Using the .removeWhere method to remove all projects where the project name matches the given name
    _projects.removeWhere((project) => project['name'] == projectName);
    // After removing a project, it notifies all its listeners about this change
    notifyListeners();
  }
}
