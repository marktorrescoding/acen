import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:openbeta/services/localstore.dart';

class StateAreasPage extends StatefulWidget {
  final String state;

  StateAreasPage({required this.state});

  @override
  _StateAreasPageState createState() => _StateAreasPageState();
}

class _StateAreasPageState extends State<StateAreasPage> {
  List<String> areaNames = [];
  List<String> downloadedStates = [];
  bool isDownloaded = false;

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
          id
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
              onPressed: () {
                saveData(widget.state);
              },
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
              builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return CircularProgressIndicator();
                }

                List areas = result.data!['areas'];
                List children = [];
                areas.forEach((area) {
                  children.addAll(area['children']);
                });

                return ListView.builder(
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    final areaName = children[index]['areaName'] as String;

                    return ListTile(
                      title: Text(areaName),
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

  void saveData(String area) async {
    areaNames.add(area);
    await LocalStore.saveAreaNames(areaNames);
    await LocalStore.saveDownloadedState(widget.state);
    setState(() {
      isDownloaded = true;
    });

    // Show a success message using a SnackBar
    final snackBar = SnackBar(
      content: Text('Areas successfully downloaded!'),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void deleteData(String area) async {
    areaNames.remove(area);
    await LocalStore.saveAreaNames(areaNames);
    await LocalStore.deleteDownloadedState(widget.state);
    setState(() {
      isDownloaded = false;
    });

    // Show a success message using a SnackBar
    final snackBar = SnackBar(
      content: Text('Areas successfully deleted!'),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateData(String area) {
    // Perform the update logic here
  }
}
