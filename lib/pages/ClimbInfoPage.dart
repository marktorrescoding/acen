import 'package:flutter/material.dart';
import 'package:openbeta/models/climb.dart';
import 'package:provider/provider.dart';
import 'package:openbeta/services/my_projects.dart';  // Assuming that MyProjects class is defined here
import 'package:openbeta/pages/home_page/home_page.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
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
              onPressed: () {
                final myProjects = Provider.of<MyProjects>(context, listen: false);
                if (myProjects.containsProject(climb.name)) {
                  myProjects.removeProject(climb.name);
                } else {
                  myProjects.addProject(climb.name, climb.yds);
                }
              },
              child: Consumer<MyProjects>(
                builder: (context, myProjects, child) {
                  final isAdded = myProjects.containsProject(climb.name);
                  return Text(isAdded ? 'Remove from My Projects' : 'Add to My Projects');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
