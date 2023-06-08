import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openbeta/pages/state_areas_page.dart';
import 'package:openbeta/services/localstore.dart';

final Map<String, String> stateNames = {
  'AL': 'Alabama',
  'AR': 'Arkansas',
  'FL': 'Florida',
  'GA': 'Georgia',
  'KY': 'Kentucky',
  'LA': 'Louisiana',
  'MS': 'Mississippi',
  'NC': 'North Carolina',
  'SC': 'South Carolina',
  'TN': 'Tennessee',
  'VA': 'Virginia',
  'WV': 'West Virginia',
  'AK': 'Alaska',
  'AZ': 'Arizona',
  'CA': 'California',
  'CO': 'Colorado',
  'HI': 'Hawaii',
  'ID': 'Idaho',
  'MT': 'Montana',
  'NV': 'Nevada',
  'NM': 'New Mexico',
  'OR': 'Oregon',
  'UT': 'Utah',
  'WA': 'Washington',
  'WY': 'Wyoming',
  'OK': 'Oklahoma',
  'TX': 'Texas',
  'CT': 'Connecticut',
  'DE': 'Delaware',
  'ME': 'Maine',
  'MD': 'Maryland',
  'MA': 'Massachusetts',
  'NH': 'New Hampshire',
  'NJ': 'New Jersey',
  'NY': 'New York',
  'PA': 'Pennsylvania',
  'RI': 'Rhode Island',
  'VT': 'Vermont',
  'IL': 'Illinois',
  'IN': 'Indiana',
  'IA': 'Iowa',
  'KS': 'Kansas',
  'MI': 'Michigan',
  'MN': 'Minnesota',
  'MO': 'Missouri',
  'NE': 'Nebraska',
  'ND': 'North Dakota',
  'OH': 'Ohio',
  'SD': 'South Dakota',
  'WI': 'Wisconsin',
};

class RegionPage extends StatefulWidget {
  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> with WidgetsBindingObserver {
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
    WidgetsBinding.instance?.addObserver(this);
    updateDownloadStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      updateDownloadStatus();
    }
  }

  void updateDownloadStatus() async {
    Map<String, bool> newDownloadStatus = {};
    List<String> downloadedStates = await LocalStore.getDownloadedStates();
    for (var abbreviation in regions.values.expand((v) => v)) {
      newDownloadStatus[abbreviation] = downloadedStates.contains(stateNames[abbreviation]);
    }

    setState(() {
      downloadStatus = newDownloadStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Select Region',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      backgroundColor: Colors.black,
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
            onStateDownloaded: updateDownloadStatus,
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
  final VoidCallback onStateDownloaded;

  RegionButton({
    required this.regionName,
    required this.states,
    required this.isSelected,
    required this.onTap,
    required this.downloadStatus,
    required this.onStateDownloaded,
  });

  final TextStyle regionButtonStyle = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle stateButtonStyle = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.black,
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
                  regionName.toUpperCase(),
                  style: regionButtonStyle.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Icon(
                  isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.white,
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
                final isDownloaded = downloadStatus[abbreviation] ?? false;
                return OutlinedButton(
                  onPressed: () async {
                    // Navigate to the StateAreasPage with full state name
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StateAreasPage(state: stateNames[abbreviation]!),
                      ),
                    );
                    // Call the callback
                    onStateDownloaded();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    side: BorderSide(color: Colors.grey),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        abbreviation,
                        style: stateButtonStyle,
                      ),
                      if (isDownloaded)
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(Icons.cloud_download, size: 16, color: Colors.green),
                        )
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
