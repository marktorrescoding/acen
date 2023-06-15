import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:openbeta/services/my_projects.dart'; // Import MyProjects
import 'widgets/search_bar.dart';
import 'widgets/app_bar/app_bar.dart';
import 'package:openbeta/pages/regions.dart'; // Import the regions page
import 'package:openbeta/pages/home_page/widgets/MyProjectsSection.dart';

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
                      CustomButton(
                        text: 'Regions',
                        icon: Icons.location_on,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegionPage()),
                        ),
                      ),
                      CustomButton(
                        text: 'Areas Near Me',
                        icon: Icons.near_me,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add spacing between the buttons and "My Projects"
                  MyProjectsSection(projects: myProjects.projects),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
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
