import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionPage extends StatefulWidget {
  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  String selectedRegion = '';
  List<String> southeastStates = [
    'AL', 'AR', 'FL', 'GA', 'KY', 'LA', 'MS', 'NC', 'SC', 'TN', 'VA', 'WV',
  ];
  List<String> westStates = [
    'AK', 'AZ', 'CA', 'CO', 'HI', 'ID', 'MT', 'NV', 'NM', 'OR', 'UT', 'WA', 'WY',
  ];
  List<String> southwestStates = ['AZ', 'NM', 'OK', 'TX'];
  List<String> northeastStates = [
    'CT', 'DE', 'ME', 'MD', 'MA', 'NH', 'NJ', 'NY', 'PA', 'RI', 'VT',
  ];
  List<String> midwestStates = [
    'IL', 'IN', 'IA', 'KS', 'MI', 'MN', 'MO', 'NE', 'ND', 'OH', 'SD', 'WI',
  ];

  List<String> getStatesForRegion(String region) {
    switch (region) {
      case 'Southeast':
        return southeastStates;
      case 'West':
        return westStates;
      case 'Southwest':
        return southwestStates;
      case 'Northeast':
        return northeastStates;
      case 'Midwest':
        return midwestStates;
      default:
        return [];
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Region'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return _buildRegionButton(
                context,
                'Southeast',
                regionButtonStyle,
              );
            case 1:
              return _buildRegionButton(
                context,
                'West',
                regionButtonStyle,
              );
            case 2:
              return _buildRegionButton(
                context,
                'Southwest',
                regionButtonStyle,
              );
            case 3:
              return _buildRegionButton(
                context,
                'Northeast',
                regionButtonStyle,
              );
            case 4:
              return _buildRegionButton(
                context,
                'Midwest',
                regionButtonStyle,
              );
            default:
              return Container();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 4) {
            // No separator after the last item
            return SizedBox.shrink();
          } else {
            return SizedBox(height: 16);  // Use a SizedBox as a divider.
          }
        },
      ),
    );
  }

  Widget _buildRegionButton(
      BuildContext context,
      String regionName,
      TextStyle textStyle,
      ) {
    bool isRegionSelected = selectedRegion == regionName;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedRegion = isRegionSelected ? '' : regionName;
            });
          },
          splashColor: Colors.transparent,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  regionName,
                  style: textStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                Icon(
                  isRegionSelected
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
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
              children: getStatesForRegion(regionName).map((abbreviation) {
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
          crossFadeState: isRegionSelected
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ],
    );
  }
}
