import 'package:flutter/material.dart';
import 'package:openbeta/models/area.dart';
import 'package:openbeta/models/climb.dart'; // Make sure to import the Climb model
import 'package:openbeta/pages/climbs_page.dart'; // And also import the ClimbsPage

class SubAreasPage extends StatelessWidget {
  final Area area;

  SubAreasPage({required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub-Areas for ${area.areaName}'),
      ),
      body: ListView.builder(
        itemCount: area.children.length,
        itemBuilder: (context, index) {
          final subArea = area.children[index];

          return ListTile(
            title: Text(subArea.areaName),
            onTap: subArea.isLeaf
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClimbsPage(area: subArea),
                ),
              );
            }
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubAreasPage(area: subArea),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
