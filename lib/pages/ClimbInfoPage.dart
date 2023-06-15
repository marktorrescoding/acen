import 'package:flutter/material.dart';
import 'package:openbeta/models/climb.dart';
import 'package:provider/provider.dart';
import 'package:openbeta/services/my_projects.dart';  // Assuming that MyProjects class is defined here

class ClimbInfoPage extends StatelessWidget {
  final Climb climb;

  ClimbInfoPage({required this.climb});

  void addToMyProjects(BuildContext context) {
    // Get the instance of MyProjects using Provider
    final myProjects = Provider.of<MyProjects>(context, listen: false);
    // Add the route name to "My Projects"
    myProjects.addProject(climb.name, climb.yds);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(climb.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Grade: ${climb.yds}', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 16.0),
            Text('Description: ${climb.content.description}', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 16.0),
            Text('Location: ${climb.content.location}', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 16.0),
            Text('Protection: ${climb.content.protection}', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => addToMyProjects(context),
              child: Text('Add to My Projects'),
            ),
          ],
        ),
      ),
    );
  }
}
