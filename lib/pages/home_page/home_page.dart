import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openbeta/services/my_projects.dart';
import 'package:openbeta/pages/regions.dart';

// Widget imports
import 'widgets/search_bar.dart';
import 'widgets/app_bar/app_bar.dart';
import 'widgets/MyProjectsSection.dart';
import 'widgets/custom_button_widget.dart';

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
                        text: 'Catalog',
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
                    child: MyProjectsSection(projects: myProjects.projects),
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
