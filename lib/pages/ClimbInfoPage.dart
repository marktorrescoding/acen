import 'package:flutter/material.dart';
import 'package:openbeta/models/climb.dart';

import 'package:flutter/material.dart';
import 'package:openbeta/models/climb.dart';

class ClimbInfoPage extends StatelessWidget {
  final Climb climb;

  ClimbInfoPage({required this.climb});

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
          ],
        ),
      ),
    );
  }
}
