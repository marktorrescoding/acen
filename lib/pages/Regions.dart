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
            onTap: () {
              setState(() {
                selectedRegion = selectedRegion == regionName ? '' : regionName;
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == regions.keys.length - 1) {
            // No separator after the last item
            return SizedBox.shrink();
          } else {
            return SizedBox(height: 16);  // Use a SizedBox as a divider.
          }
        },
      ),
    );
  }
}

class RegionButton extends StatelessWidget {
  final String regionName;
  final List<String> states;
  final bool isSelected;
  final VoidCallback onTap;

  RegionButton({
    required this.regionName,
    required this.states,
    required this.isSelected,
    required this.onTap,
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
              children: states.map((abbreviation) {
                return ElevatedButton(
                  onPressed: () {
                    // Action for state button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text(
                    abbreviation,
                    style: stateButtonStyle,
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
