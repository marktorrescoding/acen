import 'package:flutter/material.dart';

class RegionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Region'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Action for Northeast button
              },
              child: Text('Northeast'),
            ),
            ElevatedButton(
              onPressed: () {
                // Action for Midwest button
              },
              child: Text('Midwest'),
            ),
            ElevatedButton(
              onPressed: () {
                // Action for South button
              },
              child: Text('South'),
            ),
            ElevatedButton(
              onPressed: () {
                // Action for West button
              },
              child: Text('West'),
            ),
          ],
        ),
      ),
    );
  }
}
