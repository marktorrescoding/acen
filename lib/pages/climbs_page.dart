import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:openbeta/models/area.dart';
import 'package:openbeta/models/climb.dart';
import 'package:openbeta/pages/ClimbInfoPage.dart';

class ClimbsPage extends StatelessWidget {
  final Area area;

  ClimbsPage({required this.area});

  @override
  Widget build(BuildContext context) {
    final String fetchClimbs = '''
      query MyQuery(\$areaName: String!) {
        areas(filter: {area_name: {match: \$areaName, exactMatch: true}}) {
          climbs {
            name
            yds
            content {
              description
              location
              protection
            }
          }
        }
      }
    ''';

    print('Area Name: ${area.areaName}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Climbs for ${area.areaName}'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(fetchClimbs),
          variables: {'areaName': area.areaName},
        ),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            print('Query Exception: ${result.exception.toString()}');
            return Text('An error occurred while fetching data.');
          }

          if (result.isLoading) {
            return CircularProgressIndicator();
          }

          final List<Map<String, dynamic>> climbsData = result.data?['areas'][0]['climbs']?.cast<Map<String, dynamic>>() ?? [];
          final List<Climb> climbs = climbsData.map((climbData) => Climb.fromMap(climbData)).toList();

          print('Climbs data: $climbsData');
          print('Parsed climbs: $climbs');

          return ListView.builder(
            itemCount: climbs.length,
            itemBuilder: (context, index) {
              final climb = climbs[index];

              return
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(climb.name, style: TextStyle()),
                      Expanded(
                        child: Text(
                          climb.yds,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16.0, // adjust the font size to your need
                            color: Colors.black, // adjust the color to your need
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClimbInfoPage(climb: climb),
                      ),
                    );
                  },
                );

            },
          );
        },
      ),
    );
  }
}
