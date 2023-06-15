import 'package:flutter/material.dart';
import 'package:openbeta/pages/regions.dart';

class MyProjectsSection extends StatelessWidget {
  final List<Map<String, String>> projects;  // Modify the projects list to hold Maps

  const MyProjectsSection({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Icon(Icons.list),
              SizedBox(width: 8),
              Text(
                'My Projects',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          if (projects.isEmpty)
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegionPage()),
                    );
                  },
                  child: Text('Add Project'),
                ),
              ],
            )
          else
            ListView.builder(
              shrinkWrap: true,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(projects[index]['name'] ?? ''), // Display the project name
                      Text(projects[index]['grade'] ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)), // Display the grade right justified
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
