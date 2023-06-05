import 'package:flutter/material.dart';

class NearbyAreasPage extends StatefulWidget {
  final List<String> areas;

  NearbyAreasPage({required this.areas});

  @override
  _NearbyAreasPageState createState() => _NearbyAreasPageState();
}

class _NearbyAreasPageState extends State<NearbyAreasPage> {
  double _maxDistance = 10000; // Initial value

  void _updateMaxDistance(double value) {
    setState(() {
      _maxDistance = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Areas'),
      ),
      body: Column(
        children: [
          Slider(
            value: _maxDistance,
            min: 0,
            max: 10000,
            divisions: 10,
            onChanged: _updateMaxDistance,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.areas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.areas[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
