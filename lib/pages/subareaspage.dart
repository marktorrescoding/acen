import 'package:flutter/material.dart';
import 'package:openbeta/models/area.dart';

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
          );
        },
      ),
    );
  }
}
