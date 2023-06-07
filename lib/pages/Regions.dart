import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionPage extends StatefulWidget {
  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  String selectedRegion = '';
  final Map<String, List<String>> regions = {
    'Southeast': ['AL', 'AR', 'FL', 'GA', 'KY', 'LA', 'MS', 'NC', 'SC', 'TN', 'VA', 'WV'],
    'West': ['AK', 'AZ', 'CA', 'CO', 'HI', 'ID', 'MT', 'NV', 'NM', 'OR', 'UT', 'WA', 'WY'],
    'Southwest': ['AZ', 'NM', 'OK', 'TX'],
    'Northeast': ['CT', 'DE', 'ME', 'MD', 'MA', 'NH', 'NJ', 'NY', 'PA', 'RI', 'VT'],
    'Midwest': ['IL', 'IN', 'IA', 'KS', 'MI', 'MN', 'MO', 'NE', 'ND', 'OH', 'SD', 'WI'],
  };

  Map<String, bool> downloadStatus = {};

  @override
  void initState() {
    super.initState();

    regions.values.expand((v) => v).forEach((state) {
      downloadStatus[state] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Region'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: regions.keys.length,
        itemBuilder: (BuildContext context, int index) {
          String regionName = regions.keys.elementAt(index);
          return RegionButton(
            regionName: regionName,
            states: regions[regionName]!,
            isSelected: selectedRegion == regionName,
            downloadStatus: downloadStatus,
            onTap: () {
              setState(() {
                selectedRegion = selectedRegion == regionName ? '' : regionName;
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16),
      ),
    );
  }
}

class RegionButton extends StatelessWidget {
  final String regionName;
  final List<String> states;
  final bool isSelected;
  final VoidCallback onTap;
  final Map<String, bool> downloadStatus;

  RegionButton({
    required this.regionName,
    required this.states,
    required this.isSelected,
    required this.onTap,
    required this.downloadStatus,
  });

  final TextStyle regionButtonStyle = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle stateButtonStyle = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          splashColor: Colors.transparent,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  regionName,
                  style: regionButtonStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                Icon(
                  isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: Container(),
          secondChild: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: states.map((abbreviation) {
                return OutlinedButton(
                  onPressed: () {
                    downloadStatus[abbreviation] = !downloadStatus[abbreviation]!;
                    (context as Element).markNeedsBuild();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        abbreviation,
                        style: stateButtonStyle.copyWith(color: Colors.black),
                      ),
                      if (downloadStatus[abbreviation]!)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.cloud_done,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          crossFadeState: isSelected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ],
    );
  }
}
