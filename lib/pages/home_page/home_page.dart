import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:openbeta/services/my_projects.dart'; // Import MyProjects
import 'widgets/search_bar.dart';
import 'widgets/app_bar/app_bar.dart';
import 'package:openbeta/pages/regions.dart'; // Import the regions page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProjects>(
      builder: (context, myProjects, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBarWidget(),
            backgroundColor: Colors.green,
            body: Center(
              child: Column(
                children: [
                  CustomSearchBar(
                    labelText: 'Search API',
                    controller: TextEditingController(),
                    onPressed: () {},
                    isSwitched: true,
                    onSwitched: (value) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Button(
                        text: 'Regions',
                        icon: Icons.location_on,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegionPage()),
                        ),
                      ),
                      Button(
                        text: 'Areas Near Me',
                        icon: Icons.near_me,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add spacing between the buttons and "My Projects"
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Projects',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: myProjects.projects.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(myProjects.projects[index]),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const Button({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
