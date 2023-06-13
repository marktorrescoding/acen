import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:openbeta/services/localstore.dart';
import 'package:openbeta/models/area.dart';
import 'package:openbeta/models/climb.dart';

import 'package:openbeta/pages/subareaspage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StateAreasPage extends StatefulWidget {
  final String state;

  StateAreasPage({required this.state});

  @override
  _StateAreasPageState createState() => _StateAreasPageState();
}

class _StateAreasPageState extends State<StateAreasPage> {
  List<dynamic> areaNames = [];
  List<String> downloadedStates = [];
  bool isDownloaded = false;
  List<Area> areasData = [];

  @override
  void initState() {
    super.initState();
    loadDownloadedAreas();
  }

  void loadDownloadedAreas() async {
    downloadedStates = await LocalStore.getDownloadedStates();
    setState(() {
      isDownloaded = downloadedStates.contains(widget.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    String readAreas = """
      query MyQuery {
        areas(filter: {area_name: {match: "${widget.state}"}}) {
          children {
            areaName
            metadata {
              leaf
            }
            children {
              areaName
              metadata {
                leaf
              }
              children {
                areaName
                metadata {
                  leaf
                }
                children {
                  areaName
                  metadata {
                    leaf
                  }
                  children {
                    areaName
                    metadata {
                      leaf
                    }
                  }
                }
              }
            }
          }
        }
      }
    """;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.state} Climbing Areas'),
        actions: <Widget>[
          if (!isDownloaded)
            IconButton(
              icon: const Icon(Icons.download),
              tooltip: 'Download Area Names',
              onPressed: saveData,
            ),
          if (isDownloaded)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.update),
                  tooltip: 'Update Area Names',
                  onPressed: () {
                    updateData(widget.state);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete Area Names',
                  onPressed: () {
                    deleteData(widget.state);
                  },
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Query(
              options: QueryOptions(
                document: gql(readAreas),
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  // Log exception to console
                  print('Query Exception: ${result.exception.toString()}');
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return CircularProgressIndicator();
                }

                // Log result data to console
                //print('Query Result: ${result.data}');
                print('areas data: ${result.data!['areas']}');
                print('areas data: ${result.data!['areas']}');

                List<Map<String, dynamic>> areas = [];
                for (var area in result.data!['areas']) {
                  if (area['children'] != null) {
                    areas.addAll(
                        List<Map<String, dynamic>>.from(area['children']));
                  }
                }
                areasData =
                    areas.map((areaData) => Area.fromMap(areaData)).toList();

                return ListView.builder(
                  itemCount: areas.length,
                  itemBuilder: (context, index) {
                    final areaData = areas[index];
                    final area = Area.fromMap(areaData);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubAreasPage(area: area),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(area.areaName),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text('Downloaded states: ${downloadedStates.join(', ')}'),
          ),
        ],
      ),
    );
  }

  void saveData() async {
    for (var data in areasData) {
      await LocalStore.saveAreas(data);
      for (var climb in data.climbs) {
        await LocalStore.saveClimb(climb);
      }
    }
    await LocalStore.saveDownloadedState(widget.state);
    setState(() {
      isDownloaded = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Areas and routes successfully downloaded!'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }



  void deleteData(String state) async {
    await LocalStore.deleteState(state);
    setState(() {
      isDownloaded = false;
    });
  }

  void updateData(String state) async {
    String areaName = 'New Area Name';
    bool isLeaf = true;
    List<Area> children = [];
    List<Climb> climbs = []; // provide this value according to your requirement

    await LocalStore.updateState(state, areaName, isLeaf, children, climbs);

    setState(() {
      isDownloaded = true;
    });
  }
}